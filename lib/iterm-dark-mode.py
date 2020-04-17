import asyncio
import iterm2
import sys

LIGHT_PROFILE_NAME='light'
DARK_PROFILE_NAME='dark'

NEW_PROFILE=sys.argv[1]

print("changing profile to " + NEW_PROFILE)

async def main(connection):
    app = await iterm2.async_get_app(connection)
    partialProfiles = await iterm2.PartialProfile.async_query(connection)
    for partial in partialProfiles:
        if partial.name == NEW_PROFILE:
            fullProfile = await partial.async_get_full_profile()
            await app.current_terminal_window.current_tab.current_session.async_set_profile(fullProfile)
            return

iterm2.run_until_complete(main)
