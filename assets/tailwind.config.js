module.exports = {
  darkMode: false,

  mode: 'jit',

  purge: [
    '../lib/shorty_web/templates/**/*.html.heex'
  ],

  theme: {
    fill: (theme) => ({
      gray: theme('colors.gray')
    })
  }
}
