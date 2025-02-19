const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  ranspileDependencies: true,
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: false
      })
    ]
  }
})
