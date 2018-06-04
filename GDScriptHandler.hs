module GDScriptHandler where

type Line  = String

filterAttrib :: String -> String
filterAttrib [] = []
filterAttrib l@('v':'a':'r':ls) = filterEq l
filterAttrib l@('c':'o':'n':'s':'t':ls) = filterEq l
filterAttrib l = l

filterEq :: String -> String
filterEq [] = []
filterEq l = (takeWhile (\x -> (&&) (x/='=') (x/='#')) l) ++ (dropWhile (/='#') l)

filterDefinitions :: [Line] -> [Line]
filterDefinitions [] = []
filterDefinitions (l:ls)
  | l == ""              = "":(filterDefinitions ls)
  | fstChar == '\t'      = (filterDefinitions ls)
  | fstWord == "extends" = (filterDefinitions ls)
  | otherwise            = l:(filterDefinitions ls)
  where
    fstChar = head l
    fstWord = head $ words l

formatLine :: Line -> Line
formatLine [] = []
formatLine l = unwords $ words $ filterAttrib $ formatLine' l
  where
    formatLine' :: Line -> Line
    formatLine' [] = []
    formatLine' l@('f':'u':'n':'c':' ':ws) = init l
    formatLine' l = l
