import { CompositeDisposable } from 'atom'

const { systemPreferences } = require('electron').remote
const notificationsOptions = { icon: 'light-bulb' }
const subscriptions = new CompositeDisposable()

export function lightTheme(): string {
    return atom.config.get('mojave-dark-mode.lightProfile')
}

export function darkTheme(): string {
    return atom.config.get('mojave-dark-mode.darkProfile')
}

export function currentTheme(): string {
    return atom.config.get('core.themes').join(' ')
}

export function changeTheme(theme: string = '') {
    atom.config.set('core.themes', theme.split(' '))
}

export function onLight() {
    const lightTheme = this.lightTheme()

    if (this.currentTheme() != lightTheme) {
        this.changeTheme(lightTheme)
        if (atom.config.get("mojave-dark-mode.notifyOnChange")) {
            atom.notifications.addSuccess(
                'Dark Mode: Switched to light theme',
                 notificationsOptions
             )
        }
    }
}

export function onDark() {
    const darkTheme = this.darkTheme()

    if (this.currentTheme() != darkTheme) {
        this.changeTheme(darkTheme)
        if (atom.config.get("mojave-dark-mode.notifyOnChange")) {
            atom.notifications.addSuccess(
                'Dark Mode: Switched to dark theme',
                notificationsOptions
            )
        }
    }
}

export function systemThemeDidChange() {
    if (systemPreferences.isDarkMode()) {
        this.onDark()
    } else {
        this.onLight()
    }
}

export function toggle() {
    const lightTheme = this.lightTheme()
    const darkTheme = this.darkTheme()
    let next: string = (this.currentTheme() == darkTheme ? lightTheme : darkTheme)

    return this.changeTheme(next)
}

export function activate() {
    if (process.platform == 'darwin') {
        subscriptions.add(atom.commands.add('atom-workspace', {
            'mojave-dark-mode:toggle': () => this.toggle()
        }))
        systemPreferences.subscribeNotification(
            'AppleInterfaceThemeChangedNotification', this.systemThemeDidChange.bind(this))

        this.systemThemeDidChange()
    } else {
        this.deactivate()

        console.log("mojave-dark-mode is only compatible with macOS 10.14+")
    }
}

export function deactivate() {
    subscriptions.dispose()
}
