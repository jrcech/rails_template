const webpack = require("webpack");

module.exports = {
  plugin: new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.jQuery": "jquery",
    Popper: ["popper.js", "default"]
  })
};
