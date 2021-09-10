import Alpine from 'alpinejs'

// This Regex will match strings that contain a dot and 2 letters at the end
// (like a top level domain) and does not contain :// at the start.
const noSchemeUrlRegex = /^((?!(.*:\/\/)).).*\.[a-z0-9]{2,}$/i

window.alpine = Alpine

window.copyToClipboard = (text) => {
  if (navigator.clipboard != null) {
    navigator.clipboard.writeText(text)
  }
}

window.urlInsertHelper = (url) => {
  if (url != null && url.match(noSchemeUrlRegex)) {
    return `https://${url}`
  } else {
    return url
  }
}

Alpine.start()
