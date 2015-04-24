module UsePictures where

import PicturesSVG

whiteHorse :: Picture
whiteHorse = invertColour horse

rotateHorse :: Picture
rotateHorse = flipH $ flipV horse

bw1 :: Picture
bw1 = (white `beside` black) `above` (black `beside` white)

bw2 :: Picture
bw2 = (white `above` black) `beside` (black `above` white)

line :: Picture
line = white `beside` black `beside` white `beside` black `beside` white `beside` black `beside` white `beside` black

invertedLine :: Picture
invertedLine = invertColour line

checkerBoard :: Picture
checkerBoard = line `above` invertedLine `above` line `above` invertedLine `above` line `above` invertedLine `above` line `above` invertedLine

horsesLine :: Picture
horsesLine = horse `beside` whiteHorse

invertedHorsesLine :: Picture
invertedHorsesLine = invertColour horsesLine

h1 :: Picture
h1 = horsesLine `above` invertedHorsesLine

h2 :: Picture
h2 = horsesLine `above` (flipV invertedHorsesLine)

h3 :: Picture
h3 = horsesLine `above` (flipV $ flipH invertedHorsesLine)