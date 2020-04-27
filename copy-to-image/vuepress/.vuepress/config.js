const sb = require("./sidebar.json");

module.exports = {
  title: 'VuePress demo',
  description: 'Just playing around',
  plugins: [
    'vuepress-plugin-mermaidjs'
  ],
  themeConfig: {
    sidebarDepth: 5,
    nav: [
      {
        text: 'Home',
        link: '/'
      }
    ],
    sidebar: {
      '/': sb
    }
  }
}
