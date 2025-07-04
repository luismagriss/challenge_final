# CustomBrowserUtils.py
import json
from robot.libraries.BuiltIn import BuiltIn

def get_jwt_from_local_storage() -> str:
    """
    Waits for the JWT token to exist directly under the 'token' key
    in localStorage and returns its value.
    """
    builtin = BuiltIn()

    # The key we are now targeting directly in localStorage.
    token_key = "token"
    get_script = f"window.localStorage.getItem('{token_key}')"

    # We use 'Wait Until Keyword Succeeds' to handle any race conditions,
    # ensuring we only proceed once the token is actually saved.
    builtin.wait_until_keyword_succeeds(
        "10s",
        "1s",
        "Get And Verify LocalStorage Item",
        get_script
    )

    # Now that we know the token exists, we retrieve its value.
    token_value = builtin.run_keyword("Browser.Evaluate Javascript", None, get_script)

    if not token_value:
        raise Exception("Failed to retrieve token from localStorage after waiting.")

    # Log the found token for verification.
    builtin.log_to_console(f"\n--- SUCCESS: Found token: {token_value[:30]}...")

    return token_value


def get_and_verify_localstorage_item(script_to_run: str):
    """
    A helper keyword used by 'Wait Until Keyword Succeeds'.
    It runs 'Browser.Evaluate Javascript' and fails if the result is empty.
    """
    builtin = BuiltIn()
    result = builtin.run_keyword("Browser.Evaluate Javascript", None, script_to_run)
    
    if not result:
        raise AssertionError("LocalStorage item not found yet.")

