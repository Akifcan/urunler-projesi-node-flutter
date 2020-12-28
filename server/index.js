const express = require('express')
const cors = require('cors')
const { searchProduct, searchMarket } = require('./product')

const app = express()
app.use(cors())

app.get('/search-product/:keyword', async (req, res) => {
    console.log(req.params.keyword)
    const products = await searchProduct(req.params.keyword)
    res.status(200).json(products)
})

app.get('/search-market/:keyword', async (req, res) => {
    const products = await searchMarket(req.params.keyword)
    res.status(200).json(products)
})


app.listen(process.env.PORT || 3000, () => console.log('Working on 3000'))