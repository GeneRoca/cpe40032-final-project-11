-- SIZE OF ACTUAL WINDOW
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- VIRTUAL SIZE
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- STORY STATE COUNTDOWN TIME 
COUNTDOWN_TIME = 0.75

-- INITIALIZE THE LETTERS USE FOR TYPING
ALPHABET = "abcdefghijklmnopqrstuvwxyz'"

-- CREATE TABLE FOR WORDS
words = {}

-- INITIALIZE CURRENT CURSOR AND LETTER-TO-TYPE POSITION
currentCharIndex = 1

-- BOOLS
attacks = false

plays = false

near = true

cursor = false

tips = false

gameOver = false

speeds = 0

letters = 0

empower = 0

additional = 0

-- FUNCTIONS TO CALL ANYWHERE

-- FUNCTION THAT WILL INITIALIZE OUR DICTIONARY
function initializeDictionary()

    for line in love.filesystem.lines('large.txt') do
        table.insert(words, line) 
    end

end

-- FUNCTION THAT WILL CHOOSE RANDOM WORDS FROM OUR DICTIONARY
function chooseWord()

    currentCharIndex = 1

    fullString = words[math.random(#words)]

    -- EASY 
    while(fullString:len() > 6 and difficulties == 1) do
        fullString = words[math.random(#words)]
    end

    -- NORMAL
    while(fullString:len() > 8 and fullString:len() < 4 and difficulties == 2) do
        fullString = words[math.random(#words)]
    end

    -- HARD
    while(fullString:len() < 8 and difficulties == 3) do
        fullString = words[math.random(#words)]
    end

end




