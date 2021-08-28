import { resolve } from 'path'

export default {
  build: {
    assetsDir: resolve(__dirname),
    emptyOutDir: true,
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
