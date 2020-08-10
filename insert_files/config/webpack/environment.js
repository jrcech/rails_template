const pluginProvide = require("./plugins/provide");

environment.plugins.prepend("Provide", pluginProvide.plugin);
