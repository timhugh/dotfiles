require('lsp').configure_lsp('kotlin_lsp', {
  enabled = true,
  -- TODO: brew kotlin-lsp doesn't put intellij-server in PATH
  cmd = { '/opt/homebrew/Caskroom/kotlin-lsp/262.4739.0/kotlin-server-262.4739.0/bin/intellij-server', '--stdio' },
  filetypes = { 'kotlin' },
  root_markers = {
    'gradlew',
    'settings.gradle',
    'settings.gradle.kts',
    'build.gradle',
    'build.gradle.kts',
    'mvnw',
    'pom.xml',
    'build.xml',
  },
  init_options = {},
})
