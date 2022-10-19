#!/usr/bin/env python3
# Import the iterm2 python module to provide an interface for communicating with iTerm
import iterm2
import sys
# All the script logic goes in the main function
# `connection` holds the link to a running iTerm2 process
# `async` indicates that this function can be interrupted. This is required because
#  iTerm2 communicates with the script over a websocket connection,
#  any time the script sends/receives info from iterm2, it has to wait for a few milliseconds.
print(sys.argv)
async def main(connection):
    # Get a reference to the iterm2.App object - a singleton that provides access to iTerm2’s windows,
    # and in turn their tabs and sessions.
    app = await iterm2.async_get_app(connection)
    # Fetch the “current terminal window” from the app (returns None if there is no current window)
    window = app.current_terminal_window
    if window is not None:
        # Add a tab to current window using the default profile
        await window.async_create_tab()
        session = app.current_terminal_window.current_tab.current_session
        await session.async_send_text(f'cd /Volumes/LIB/IT/CODE/{sys.argv[1]}\n')
        await session.async_send_text('npm run dev\n')
    else:
        # You can view this message in the script console.
        print("No current window")
# Make a connection to iTerm2 and invoke the main function in an asyncio event loop.
# When main returns the program terminates.
iterm2.run_until_complete(main)