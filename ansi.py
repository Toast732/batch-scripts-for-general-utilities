# We need to import os.system, and then run an empty command, for ansi colours to work.
from os import system

system("")

from typing import List

import re

import colorsys

# See https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
# For a preview. Match to your terminal

# ANSI Clear code (Removes all formatting).
ANSI_CLEAR = "\033[0m"

# ANSI Dark foregrounds.
FG_BLACK = "\033[30m"
FG_RED = "\033[31m"
FG_GREEN = "\033[32m"
FG_YELLOW = "\033[33m"
FG_BLUE = "\033[34m"
FG_MAGENTA = "\033[35m"
FG_CYAN = "\033[36m"
FG_WHITE = "\033[37m"

# ANSI bright foregrounds.
FG_GRAY = "\033[90m"
FG_B_RED = "\033[91m"
FG_B_GREEN = "\033[92m"
FG_B_YELLOW = "\033[93m"
FG_B_BLUE = "\033[94m"
FG_B_MAGENTA = "\033[95m"
FG_B_CYAN = "\033[96m"
FG_B_WHITE = "\033[97m"

BG_BLACK = "\033[40m"
BG_RED = "\033[41m"
BG_GREEN = "\033[42m"
BG_YELLOW = "\033[43m"
BG_BLUE = "\033[44m"
BG_MAGENTA = "\033[45m"
BG_CYAN = "\033[46m"
BG_WHITE = "\033[47m"

BG_GRAY = "\033[100m"
BG_B_RED = "\033[101m"
BG_B_GREEN = "\033[102m"
BG_B_YELLOW = "\033[103m"
BG_B_BLUE = "\033[104m"
BG_B_MAGENTA = "\033[105m"
BG_B_CYAN = "\033[106m"
BG_B_WHITE = "\033[107m"

# Strips any ansi out of the given string.
def strip_ansi(string_to_strip: str) -> str:
    return re.sub(
        r"\[\d{1,3}m",
        "",
        string_to_strip
    )

FG_24_BIT_CODE = 38
BG_24_BIT_CODE = 48

def create_fg_from_rgb(r, g, b):
    return _create_24bit_colour(FG_24_BIT_CODE, r, g, b)

def create_bg_from_rgb(r, g, b):
    return _create_24bit_colour(BG_24_BIT_CODE, r, g, b)

def generate_colour_hue_list(start_deg: float, end_deg: float, sat: float, val: float, steps: int, is_bg: bool = False) -> List[str]:

    colour_list = []

    # Convert deg from 0-360 to 0-1.
    start_deg /= 360
    end_deg /= 360

    # Convert sat from 0-100 to 0-1.
    sat /= 100

    # Convert val from 0-100 to 0.1.
    val /= 100

    # Get the step amount.
    step_amount = (end_deg-start_deg)/(steps-1)

    for step_num in range(steps):
        # Get our current deg
        deg = (start_deg + step_amount * step_num)%1

        # Get the colour.
        raw_colour = colorsys.hsv_to_rgb(deg, sat, val)

        colour = (
            int(raw_colour[0] * 255),
            int(raw_colour[1] * 255),
            int(raw_colour[2] * 255)
        )

        # Convert to the 24 bit colour.
        if not is_bg:
            colour_list.append(
                create_fg_from_rgb(
                    colour[0],
                    colour[1],
                    colour[2]
                )
            )
        else:
            colour_list.append(
                create_bg_from_rgb(
                    colour[0],
                    colour[1],
                    colour[2]
                )
            )

    # Return the colour list.
    return colour_list
    
def _create_24bit_colour(code, r, g, b):
    return f"\033[{code};2;{r};{g};{b}m"