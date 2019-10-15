-- SIZE OF ACTUAL WINDOW
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- VIRTUAL SIZE
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

COUNTDOWN_TIME = 0.75

ALPHABET = "abcdefghijklmnopqrstuvwxyz'"

words = {}

currentCharIndex = 1

function initializeDictionary()

    for line in love.filesystem.lines('large.txt') do
        table.insert(words, line) 
    end

end

function chooseWord()
    currentCharIndex = 1
    fullString = words[math.random(#words)]
    
end

cursor = false

score = 0

attacks = false