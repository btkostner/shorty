module.exports = {
  darkMode: false,

  mode: 'jit',

  purge: [
    '../lib/shorty_web/templates/**/*.html.heex'
  ],

  theme: {
    fontFamily: {
      sans: [
        'inter',
        '"Open Sans"',
        '"Nato Sans"',
        'Roboto',
        '"Droid Sans"',
        'sans-serif'
      ]
    },

    fill: (theme) => ({
      gray: theme('colors.gray')
    })
  }
}
