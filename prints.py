from .ansi import (
    FG_B_BLUE,
    FG_B_GREEN,
    FG_B_YELLOW,
    FG_B_RED,
    FG_B_CYAN,
    ANSI_CLEAR,
    create_fg_from_rgb
)
from string import Template

PRINT_HEADER = f"{FG_B_BLUE}> {ANSI_CLEAR}"

PRINT_FOOTER = f"{ANSI_CLEAR}"

class PrintTemplate(Template):
    pass

INFO_PRINT_TEMPLATE = PrintTemplate(f"{FG_B_BLUE}$message")

SUCCESS_PRINT_TEMPLATE = PrintTemplate(f"{FG_B_GREEN}$message")

PENDING_PRINT_TEMPLATE = PrintTemplate(f"{FG_B_CYAN}$message")

WARNING_PRINT_TEMPLATE = PrintTemplate(f"{FG_B_YELLOW}$message")

SEVERE_WARNING_PRINT_TEMPLATE = PrintTemplate(f"{create_fg_from_rgb(255, 106, 0)}$message")

ERROR_PRINT_TEMPLATE = PrintTemplate(f"{FG_B_RED}$message")

def _print(message: str, template: PrintTemplate):
    """
    Prints a message to the console with a header and footer.
    
    Args:
        print_message (str): The message to print.
    """
    print(f"{PRINT_HEADER}{template.safe_substitute(message=message)}{PRINT_FOOTER}")

def print_info(message: str):
    """
    Prints an info message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, INFO_PRINT_TEMPLATE)

def print_success(message: str):
    """
    Prints a success message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, SUCCESS_PRINT_TEMPLATE)

def print_pending(message: str):
    """
    Prints a pending message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, PENDING_PRINT_TEMPLATE)

def print_warning(message: str):
    """
    Prints a warning message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, WARNING_PRINT_TEMPLATE)

def print_severe_warning(message: str):
    """
    Prints a severe warning message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, SEVERE_WARNING_PRINT_TEMPLATE)

def print_error(message: str):
    """
    Prints an error message to the console.
    
    Args:
        message (str): The message to print.
    """
    _print(message, ERROR_PRINT_TEMPLATE)