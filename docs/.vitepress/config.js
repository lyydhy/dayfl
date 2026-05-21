import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Dayfl',
  description: '纯 Dart 日期格式化工具库',
  base: '/dayfl/',
  
  themeConfig: {
    logo: '/logo.svg',
    nav: [
      { text: '首页', link: '/' },
      { text: '指南', link: '/guide/' },
      { text: 'API', link: '/guide/api' },
      { text: 'GitHub', link: 'https://github.com/lyydhy/dayfl' }
    ],

    sidebar: {
      '/guide/': [
        {
          text: '指南',
          items: [
            { text: '简介', link: '/guide/' },
            { text: '快速开始', link: '/guide/getting-started' },
            { text: 'API 文档', link: '/guide/api' },
            { text: '格式化占位符', link: '/guide/format' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/lyydhy/dayfl' }
    ],

    footer: {
      message: '基于 MIT 许可证发布',
      copyright: '© 2024 Dayfl'
    }
  }
})
