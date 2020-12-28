const axios = require('axios')
const cheerio = require('cheerio')

async function searchProduct(keyword) {
    keyword = keyword.replace(/ı/g, 'i').replace(/ç/g, 'c').replace(/İ/g, 'i').replace(/ç/g, 'c')
    const n11Response = await axios.get(`https://www.n11.com/arama?q=${keyword}`)
    const hepsiBuradaResponse = await axios.get(`https://www.hepsiburada.com/ara?q=${keyword}`)
    const gittiGidiyorResponse = await axios.get(`https://www.gittigidiyor.com/arama/?k=${keyword}`)


    const $n11 = cheerio.load(n11Response.data)
    const $hepsiBurada = cheerio.load(hepsiBuradaResponse.data)
    const $gittiGidiyor = cheerio.load(gittiGidiyorResponse.data)


    const products = []

    //n11
    $n11('ul.clearfix').find('li').each(function (index, element) {
        const productName = $n11(element).find('.productName').text().trim()
        const productImage = $n11(element).find('img').attr('data-original')
        const productLink = $n11(element).find('.plink').attr('href')
        const productPrice = parseFloat($n11(element).find('ins').text())
        if (productName != undefined && productName != '') {
            products.push({ productName, productImage, productLink, productPrice, brand: 'n11', source: 'https://www.n11.com' })
        }
    })

    //hepsiburada
    $hepsiBurada('.product-list').find('.search-item').each(function (index, element) {
        const productName = $hepsiBurada(element).find('.product-title').text().trim()
        const productPrice = parseFloat($hepsiBurada(element).find('.product-price').text())
        const productLink = `https://www.hepsiburada.com${$hepsiBurada(element).find('a').attr('href')}`
        const productImage = $hepsiBurada(element).find('noscript').html().split('"')[1]

        if (!isNaN(productPrice)) {
            products.push({ productName, productPrice, productLink, productImage, brand: 'Hepsiburada', source: 'https://www.hepsiburada.com' })
        }

    })

    //gittigidiyor
    $gittiGidiyor('.products-container').find('li').each(function (i, elem) {
        const productLink = $gittiGidiyor(elem).find('a').attr('href')
        const productImage = $gittiGidiyor(elem).find('img').attr('data-original')
        const productPrice = parseFloat($gittiGidiyor(elem).find('.price-txt').text().replace(/,/g, '.').replace(/(\.[0-9]*[1-9])0+$|\.0*$/, '$1'))
        const productName = $gittiGidiyor(elem).find('.product-title ').text().trim()
        if (productName.trim().length > 0 && productLink != undefined && productImage != undefined) {
            products.push({ productName, productPrice, productLink, productImage, brand: 'GittiGidiyor', source: 'https://www.gittigidiyor.com' })
        }
    })



    return products.sort((a, b) => {
        if (a.productPrice > b.productPrice) {
            return 1
        } else {
            return -1
        }
    })
}


async function searchMarket(keyword) {
    keyword = keyword.replace(/ı/g, 'i').replace(/ş/g, 's').replace(/ç/g, 'c').replace(/ö/g, 'o').replace(/ /g, '+')

    const migrosResponse = await axios.get(`https://www.migros.com.tr/arama?q=${keyword}`)
    const isteGelsinResponse = await axios.get(`https://www.istegelsin.com/arama/${keyword}`)
    const carrefoursaResponse = await axios.get(`https://www.carrefoursa.com/search/?text=${keyword}`)

    const $migros = cheerio.load(migrosResponse.data)
    const $isteGelsin = cheerio.load(isteGelsinResponse.data)
    const $carrefoursa = cheerio.load(carrefoursaResponse.data)

    const products = []

    // migros
    $migros('.sub-category-product-list').find('.list').each(function (i, elem) {
        const productLink = `https://www.migros.com.tr/${$migros(elem).find('a').attr('href')}`;
        const productName = $migros(elem).find('.title').text()
        const productImage = $migros(elem).find('.product-card-image').attr('data-src')
        const productPrice = parseFloat($migros(elem).find('.price-tag').text().replace(',', '.'))
        products.push({ productName, productLink, productPrice, productImage, brand: 'Migros', source: 'https://www.migros.com.tr' })
    })

    //istegelsin
    $isteGelsin('#productList').find('.v3-global-product-item').each(function (i, elem) {
        const productLink = `https://www.istegelsin.com${$isteGelsin(elem).find('a').attr('href')}`
        const productImage = $isteGelsin(elem).find('img').attr('src')
        const productName = $isteGelsin(elem).find('.product-name').text()
        const productPrice = parseFloat($isteGelsin(elem).find('.price-box-add').text().replace(/,/g, '.'))
        products.push({ productName, productLink, productPrice, productImage, brand: 'İste Gelsin', source: 'https://www.istegelsin.com' })
    })

    //carrefoursa
    $carrefoursa('.product-listing').find('li').each(function (i, elem) {
        const productLink = `https://www.carrefoursa.com${$carrefoursa(elem).find('a').attr('href')}`
        const productImage = $carrefoursa(elem).find('img').attr('data-src')
        const productName = $carrefoursa(elem).find('.item-name').text()
        const productPrice = parseFloat($carrefoursa(elem).find('.item-price').attr('content'))
        products.push({ productName, productLink, productPrice, productImage, brand: 'CarrefourSA', source: 'https://www.carrefoursa.com' })
    })

    return products.sort((a, b) => {
        if (a.productPrice > b.productPrice) {
            return 1
        } else {
            return -1
        }
    })

}

// searchMarket('beyaz çikolata')
//     .then(response => {
//         console.log(response)
//     })

// searchProduct('adidas ceket')
//     .then(response => {
//         console.log(response);
//     })

module.exports = {
    searchMarket, searchProduct
}
