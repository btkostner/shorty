import { resolve } from 'path'

export default {
  build: {
    assetsDir: resolve(__dirname),
    // This silences a warning message about not emptying the output dir. It
    // does nothing and removing it will have the same result + a log message.
    emptyOutDir: false,
    outDir: resolve(__dirname, '../priv/static'),
    rollupOptions: {
      input: './scripts/main.js',
      output: {
        entryFileNames: 'assets/[name].js',
        chunkFileNames: 'assets/[name].js',
        assetFileNames: 'assets/[name].[ext]'
      }
    }
  },
  logLevel: process.env.VITE_LOG_LEVEL || 'info',
  mode: 'production'
}
