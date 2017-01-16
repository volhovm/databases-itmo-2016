{-# LANGUAGE OverloadedStrings #-}
-- | Splices

module ParserExtra
       ( customOptions
       , randomSSH
       , randomB64
       , withProb
       , randomEmail
       , allNamesSurnames
       , topHackagePackages
       ) where

import           Control.Monad          (replicateM)
import           Data.Aeson.TH          (Options (..), defaultOptions)
import qualified Data.ByteString        as BS
import qualified Data.ByteString.Base64 as B64
import           Data.Maybe             (fromJust)
import           Data.Monoid            ((<>))
import           Data.Text              (Text)
import qualified Data.Text              as T
import           Data.Text.Encoding     (decodeUtf8)
import           System.Random          (randomIO, randomRIO)

customOptions = defaultOptions {
    fieldLabelModifier =
          \x ->
            let stripped = tail $ dropWhile (/= '_') x
            in T.unpack $ T.replace "_" "-" $ T.pack stripped
    }

withProb :: Double -> a -> a -> IO a
withProb prob x y = do
    z <- randomRIO (0, 1 :: Double)
    pure $ if z < prob then x else y

randomSSH :: Text -> IO Text
randomSSH email = do
    key <- randomB64 256
    pure $ "ssh-rsa " <> key <> " " <> email

-- random 64 of given byte length
randomB64 :: Int -> IO Text
randomB64 length = do
    randomBS <- BS.pack <$> replicateM length randomIO
    pure $ decodeUtf8 $ B64.encode randomBS

randomEmail :: Text -> IO Text
randomEmail prefix = do
    i <- randomRIO (0, length suffixes - 1)
    pure $ prefix <> "@" <> suffixes !! i
  where
    suffixes = ["gmail.com", "mail.ru", "yandex.ru", "yahoo.com", "tempmail.com", "extramail.com", "list.com"]

allNamesSurnames :: [Text]
allNamesSurnames = [ a <> " " <> b | a <- allNames, b <- allSurnames ]

allNames :: [Text]
allNames =
    [ "Noah", "Liam", "Mason", "Jacob", "William", "Ethan", "James", "Alexander", "Michael", "Benjamin", "Elijah", "Daniel", "Aiden", "Logan", "Matthew", "Lucas", "Jackson", "David", "Oliver", "Jayden", "Joseph", "Gabriel", "Samuel", "Carter", "Anthony", "John", "Dylan", "Luke", "Henry", "Andrew", "Isaac", "Christopher", "Joshua", "Wyatt", "Sebastian", "Owen", "Caleb", "Nathan", "Ryan", "Jack", "Hunter", "Levi", "Christian", "Jaxon", "Julian", "Landon", "Grayson", "Jonathan", "Isaiah", "Charles", "Thomas", "Aaron", "Eli", "Connor", "Jeremiah", "Cameron", "Josiah", "Adrian", "Colton", "Jordan", "Brayden", "Nicholas", "Robert", "Angel", "Hudson", "Lincoln", "Evan", "Dominic", "Austin", "Gavin", "Nolan", "Parker", "Adam", "Chase", "Jace", "Ian", "Cooper", "Easton", "Kevin", "Jose", "Tyler", "Brandon", "Asher", "Jaxson", "Mateo", "Jason", "Ayden", "Zachary", "Carson", "Xavier", "Leo", "Ezra", "Bentley", "Sawyer", "Kayden", "Blake", "Nathaniel", "Ryder", "Theodore", "Elias", "Tristan", "Roman", "Leonardo", "Camden", "Brody", "Luis", "Miles", "Micah", "Vincent", "Justin", "Greyson", "Declan", "Maxwell", "Juan", "Cole", "Damian", "Carlos", "Max", "Harrison", "Weston", "Brantley", "Braxton", "Axel", "Diego", "Abel", "Wesley", "Santiago", "Jesus", "Silas", "Giovanni", "Bryce", "Jayce", "Bryson", "Alex", "Everett", "George", "Eric", "Ivan", "Emmett", "Kaiden", "Ashton", "Kingston", "Jonah", "Jameson", "Kai", "Maddox", "Timothy", "Ezekiel", "Ryker", "Emmanuel", "Hayden", "Antonio", "Bennett", "Steven", "Richard", "Jude", "Luca", "Edward", "Joel", "Victor", "Miguel", "Malachi", "King", "Patrick", "Kaleb", "Bryan", "Alan", "Marcus", "Preston", "Abraham", "Calvin", "Colin", "Bradley", "Jeremy", "Kyle", "Graham", "Grant", "Jesse", "Kaden", "Alejandro", "Oscar", "Jase", "Karter", "Maverick", "Aidan", "Tucker", "Avery", "Amir", "Brian", "Iker", "Matteo", "Caden", "Zayden", "Riley", "August", "Mark", "Maximus", "Brady", "Kenneth", "Paul", "Jaden", "Nicolas", "Beau", "Dean", "Jake", "Peter", "Xander", "Elliot", "Finn", "Derek", "Sean", "Cayden", "Elliott", "Jax", "Jasper", "Lorenzo", "Omar", "Beckett", "Rowan", "Gael", "Corbin", "Waylon", "Myles", "Tanner", "Jorge", "Javier", "Zion", "Andres", "Charlie", "Paxton", "Emiliano", "Brooks", "Zane", "Simon", "Judah", "Griffin", "Cody", "Gunner", "Dawson", "Israel", "Rylan", "Gage", "Messiah", "River", "Kameron", "Stephen", "Francisco", "Clayton", "Zander", "Chance", "Eduardo", "Spencer", "Lukas", "Damien", "Dallas", "Conner", "Travis", "Knox", "Raymond", "Peyton", "Devin", "Felix", "Jayceon", "Collin", "Amari", "Erick", "Cash", "Jaiden", "Fernando", "Cristian", "Josue", "Keegan", "Garrett", "Rhett", "Ricardo", "Martin", "Reid", "Seth", "Andre", "Cesar", "Titus", "Donovan", "Manuel", "Mario", "Caiden", "Adriel", "Kyler", "Milo", "Archer", "Jeffrey", "Holden", "Arthur", "Karson", "Rafael", "Shane", "Lane", "Louis", "Angelo", "Remington", "Troy", "Emerson", "Maximiliano", "Hector", "Emilio", "Anderson", "Trevor", "Phoenix", "Walter", "Johnathan", "Johnny", "Edwin", "Julius", "Barrett", "Leon", "Tyson", "Tobias", "Edgar", "Dominick", "Marshall", "Marco", "Joaquin", "Dante", "Andy", "Cruz", "Ali", "Finley", "Dalton", "Gideon", "Reed", "Enzo", "Sergio", "Jett", "Thiago", "Kyrie", "Ronan", "Cohen", "Colt", "Erik", "Trenton", "Jared", "Walker", "Landen", "Alexis", "Nash", "Jaylen", "Gregory", "Emanuel", "Killian", "Allen", "Atticus", "Desmond", "Shawn", "Grady", "Quinn", "Frank", "Fabian", "Dakota", "Roberto", "Beckham", "Major", "Skyler", "Nehemiah", "Drew", "Cade", "Muhammad", "Kendrick", "Pedro", "Orion", "Aden", "Kamden", "Ruben", "Zaiden", "Clark", "Noel", "Porter", "Solomon", "Romeo", "Rory", "Malik", "Daxton", "Leland", "Kash", "Abram", "Derrick", "Kade", "Gunnar", "Prince", "Brendan", "Leonel", "Kason", "Braylon", "Legend", "Pablo", "Jay", "Adan", "Jensen", "Esteban", "Kellan", "Drake", "Warren", "Ismael", "Ari", "Russell", "Bruce", "Finnegan", "Marcos", "Jayson", "Theo", "Jaxton", "Phillip", "Dexter", "Braylen", "Armando", "Braden", "Corey", "Kolton", "Gerardo", "Ace", "Ellis", "Malcolm", "Tate", "Zachariah", "Chandler", "Milan", "Keith", "Danny", "Damon", "Enrique", "Jonas", "Kane", "Princeton", "Hugo", "Ronald", "Philip", "Ibrahim", "Kayson", "Maximilian", "Lawson", "Harvey", "Albert", "Donald", "Raul", "Franklin", "Hendrix", "Odin", "Brennan", "Jamison", "Dillon", "Brock", "Landyn", "Mohamed", "Brycen", "Deacon", "Colby", "Alec", "Julio", "Scott", "Matias", "Sullivan", "Rodrigo", "Cason", "Taylor", "Rocco", "Nico", "Royal", "Pierce", "Augustus", "Raiden", "Kasen", "Benson", "Moses", "Cyrus", "Raylan", "Davis", "Khalil", "Moises", "Conor", "Nikolai", "Alijah", "Mathew", "Keaton", "Francis", "Quentin", "Ty", "Jaime", "Ronin", "Kian", "Lennox", "Malakai", "Atlas", "Jerry", "Ryland", "Ahmed", "Saul", "Sterling", "Dennis", "Lawrence", "Zayne", "Bodhi", "Arjun", "Darius", "Arlo", "Eden", "Tony", "Dustin", "Kellen", "Chris", "Mohammed", "Nasir", "Omari", "Kieran", "Nixon", "Rhys", "Armani", "Arturo", "Bowen", "Frederick", "Callen", "Leonidas", "Remy", "Wade", "Luka", "Jakob", "Winston", "Justice", "Alonzo", "Curtis", "Aarav", "Gustavo", "Royce", "Asa", "Gannon", "Kyson", "Hank", "Izaiah", "Roy", "Raphael", "Luciano", "Hayes", "Case", "Darren", "Mohammad", "Otto", "Layton", "Isaias", "Alberto", "Jamari", "Colten", "Dax", "Marvin", "Casey", "Moshe", "Johan", "Sam", "Matthias", "Larry", "Trey", "Devon", "Trent", "Mauricio", "Mathias", "Issac", "Dorian", "Gianni", "Ahmad", "Nikolas", "Oakley", "Uriel", "Lewis", "Randy", "Cullen", "Braydon", "Ezequiel", "Reece", "Jimmy", "Crosby", "Soren", "Uriah", "Roger", "Nathanael", "Emmitt", "Gary", "Rayan", "Ricky", "Mitchell", "Roland", "Alfredo", "Cannon", "Jalen", "Tatum", "Kobe", "Yusuf", "Quinton", "Korbin", "Brayan", "Joe", "Byron", "Ariel", "Quincy", "Carl", "Kristopher", "Alvin", "Duke", "Lance", "London", "Jasiah", "Boston", "Santino", "Lennon", "Deandre", "Madden", "Talon", "Sylas", "Orlando", "Hamza", "Bo", "Aldo", "Douglas", "Tristen", "Wilson", "Maurice", "Samson", "Cayson", "Bryant", "Conrad", "Dane", "Julien", "Sincere", "Noe", "Salvador", "Nelson", "Edison", "Ramon", "Lucian", "Mekhi", "Niko", "Ayaan", "Vihaan", "Neil", "Titan", "Ernesto", "Brentley", "Lionel", "Zayn", "Dominik", "Cassius", "Rowen", "Blaine", "Sage", "Kelvin", "Jaxen", "Memphis", "Leonard", "Abdullah", "Jacoby", "Allan", "Jagger", "Yahir", "Forrest", "Guillermo", "Mack", "Zechariah", "Harley", "Terry", "Kylan", "Fletcher", "Rohan", "Eddie", "Bronson", "Jefferson", "Rayden", "Terrance", "Marc", "Morgan", "Valentino", "Demetrius", "Kristian", "Hezekiah", "Lee", "Alessandro", "Makai", "Rex", "Callum", "Kamari", "Casen", "Tripp", "Callan", "Stanley", "Toby", "Elian", "Langston", "Melvin", "Payton", "Flynn", "Jamir", "Kyree", "Aryan", "Axton", "Azariah", "Branson", "Reese", "Adonis", "Thaddeus", "Zeke", "Tommy", "Blaze", "Carmelo", "Skylar", "Arian", "Bruno", "Kaysen", "Layne", "Ray", "Zain", "Crew", "Jedidiah", "Rodney", "Clay", "Tomas", "Alden", "Jadiel", "Harper", "Ares", "Cory", "Brecken", "Chaim", "Nickolas", "Kareem", "Xzavier", "Kaison", "Alonso", "Amos", "Vicente", "Samir", "Yosef", "Jamal", "Jon", "Bobby", "Aron", "Ben", "Ford", "Brodie", "Cain", "Finnley", "Briggs", "Davion", "Kingsley", "Brett", "Wayne", "Zackary", "Apollo", "Emery", "Joziah", "Lucca", "Bentlee", "Hassan", "Westin", "Joey", "Vance", "Marcelo", "Axl", "Jermaine", "Chad", "Gerald", "Kole", "Dash", "Dayton", "Lachlan", "Shaun", "Kody", "Ronnie", "Kolten", "Marcel", "Stetson", "Willie", "Jeffery", "Brantlee", "Elisha", "Maxim", "Kendall", "Harry", "Leandro", "Aaden", "Channing", "Kohen", "Yousef", "Darian", "Enoch", "Mayson", "Neymar", "Giovani", "Alfonso", "Duncan", "Anders", "Braeden", "Dwayne", "Keagan", "Felipe", "Fisher", "Stefan", "Trace", "Aydin", "Anson", "Clyde", "Blaise", "Canaan", "Maxton", "Alexzander", "Billy", "Harold", "Baylor", "Gordon", "Rene", "Terrence", "Vincenzo", "Kamdyn", "Marlon", "Castiel", "Lamar", "Augustine", "Jamie", "Eugene", "Harlan", "Kase", "Miller", "Van", "Kolby", "Sonny", "Emory", "Junior", "Graysen", "Heath", "Rogelio", "Will", "Amare", "Ameer", "Camdyn", "Jerome", "Maison", "Micheal", "Cristiano", "Giancarlo", "Henrik", "Lochlan", "Bode", "Camron", "Houston", "Otis", "Hugh", "Kannon", "Konnor", "Emmet", "Kamryn", "Maximo", "Adrien", "Cedric", "Dariel", "Landry", "Leighton", "Magnus", "Draven", "Javon", "Marley", "Zavier", "Markus", "Justus", "Reyansh", "Rudy", "Santana", "Misael", "Abdiel", "Davian", "Zaire", "Jordy", "Reginald", "Benton", "Darwin", "Franco", "Jairo", "Jonathon", "Reuben", "Urijah", "Vivaan", "Brent", "Gauge", "Vaughn", "Coleman", "Zaid", "Terrell", "Kenny", "Brice", "Lyric", "Judson", "Shiloh", "Damari", "Kalel", "Braiden", "Brenden", "Coen", "Denver", "Javion", "Thatcher", "Rey", "Dilan", "Dimitri", "Immanuel", "Mustafa", "Ulises", "Alvaro", "Dominique", "Eliseo", "Anakin", "Craig", "Dario", "Santos", "Grey", "Ishaan", "Jessie", "Jonael", "Alfred", "Tyrone", "Valentin", "Jadon", "Turner", "Ignacio", "Riaan", "Rocky", "Ephraim", "Marquis", "Musa", "Keenan", "Ridge", "Chace", "Kymani", "Rodolfo", "Darrell", "Steve", "Agustin", "Jaziel", "Boone", "Cairo", "Kashton", "Rashad", "Gibson", "Jabari", "Avi", "Quintin", "Seamus", "Rolando", "Sutton", "Camilo", "Triston", "Yehuda", "Cristopher", "Davin", "Ernest", "Jamarion", "Kamren", "Salvatore", "Anton", "Aydan", "Huxley", "Jovani", "Wilder", "Bodie", "Jordyn", "Louie", "Achilles", "Kaeden", "Kamron", "Aarush", "Deangelo", "Robin", "Yadiel", "Yahya", "Boden", "Ean", "Kye", "Kylen", "Todd", "Truman", "Chevy", "Gilbert", "Haiden", "Brixton", "Dangelo", "Juelz", "Osvaldo", "Bishop", "Freddy", "Reagan", "Frankie", "Malaki", "Camren", "Deshawn", "Jayvion", "Leroy", "Briar", "Jaydon", "Antoine"]


allSurnames :: [Text]
allSurnames =
    [ "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes", "Myers", "Ford", "Hamilton", "Graham", "Sullivan", "Wallace", "Woods", "Cole", "West", "Jordan", "Owens", "Reynolds", "Fisher", "Ellis", "Harrison", "Gibson", "Mcdonald", "Cruz", "Marshall", "Ortiz", "Gomez", "Murray", "Freeman", "Wells", "Webb", "Simpson", "Stevens", "Tucker", "Porter", "Hunter", "Hicks", "Crawford", "Henry", "Boyd", "Mason", "Morales", "Kennedy", "Warren", "Dixon", "Ramos", "Reyes", "Burns", "Gordon", "Shaw", "Holmes", "Rice", "Robertson", "Hunt", "Black", "Daniels", "Palmer", "Mills", "Nichols", "Grant", "Knight", "Ferguson", "Rose", "Stone", "Hawkins", "Dunn", "Perkins", "Hudson", "Spencer", "Gardner", "Stephens", "Payne", "Pierce", "Berry", "Matthews", "Arnold", "Wagner", "Willis", "Ray", "Watkins", "Olson", "Carroll", "Duncan", "Snyder", "Hart", "Cunningham", "Bradley", "Lane", "Andrews", "Ruiz", "Harper", "Fox", "Riley", "Armstrong", "Carpenter", "Weaver", "Greene", "Lawrence", "Elliott", "Chavez", "Sims", "Austin", "Peters", "Kelley", "Franklin", "Lawson", "Fields", "Gutierrez", "Ryan", "Schmidt", "Carr", "Vasquez", "Castillo", "Wheeler", "Chapman", "Oliver", "Montgomery", "Richards", "Williamson", "Johnston", "Banks", "Meyer", "Bishop", "Mccoy", "Howell", "Alvarez", "Morrison", "Hansen", "Fernandez", "Garza", "Harvey", "Little", "Burton", "Stanley", "Nguyen", "George", "Jacobs", "Reid", "Kim", "Fuller", "Lynch", "Dean", "Gilbert", "Garrett", "Romero", "Welch", "Larson", "Frazier", "Burke", "Hanson", "Day", "Mendoza", "Moreno", "Bowman", "Medina", "Fowler", "Brewer", "Hoffman", "Carlson", "Silva", "Pearson", "Holland", "Douglas", "Fleming", "Jensen", "Vargas", "Byrd", "Davidson", "Hopkins", "May", "Terry", "Herrera", "Wade", "Soto", "Walters", "Curtis", "Neal", "Caldwell", "Lowe", "Jennings", "Barnett", "Graves", "Jimenez", "Horton", "Shelton", "Barrett", "Obrien", "Castro", "Sutton", "Gregory", "Mckinney", "Lucas", "Miles", "Craig", "Rodriquez", "Chambers", "Holt", "Lambert", "Fletcher", "Watts", "Bates", "Hale", "Rhodes", "Pena", "Beck", "Newman", "Haynes", "Mcdaniel", "Mendez", "Bush", "Vaughn", "Parks", "Dawson", "Santiago", "Norris", "Hardy", "Love", "Steele", "Curry", "Powers", "Schultz", "Barker", "Guzman", "Page", "Munoz", "Ball", "Keller", "Chandler", "Weber", "Leonard", "Walsh", "Lyons", "Ramsey", "Wolfe", "Schneider", "Mullins", "Benson", "Sharp", "Bowen", "Daniel", "Barber", "Cummings", "Hines", "Baldwin", "Griffith", "Valdez", "Hubbard", "Salazar", "Reeves", "Warner", "Stevenson", "Burgess", "Santos", "Tate", "Cross", "Garner", "Mann", "Mack", "Moss", "Thornton", "Dennis", "Mcgee", "Farmer", "Delgado", "Aguilar", "Vega", "Glover", "Manning", "Cohen", "Harmon", "Rodgers", "Robbins", "Newton", "Todd", "Blair", "Higgins", "Ingram", "Reese", "Cannon", "Strickland", "Townsend", "Potter", "Goodwin", "Walton", "Rowe", "Hampton", "Ortega", "Patton", "Swanson", "Joseph", "Francis", "Goodman", "Maldonado", "Yates", "Becker", "Erickson", "Hodges", "Rios", "Conner", "Adkins", "Webster", "Norman", "Malone", "Hammond", "Flowers", "Cobb", "Moody", "Quinn", "Blake", "Maxwell", "Pope", "Floyd", "Osborne", "Paul", "Mccarthy", "Guerrero", "Lindsey", "Estrada", "Sandoval", "Gibbs", "Tyler", "Gross", "Fitzgerald", "Stokes", "Doyle", "Sherman", "Saunders", "Wise", "Colon", "Gill", "Alvarado", "Greer", "Padilla", "Simon", "Waters", "Nunez", "Ballard", "Schwartz", "Mcbride", "Houston", "Christensen", "Klein", "Pratt", "Briggs", "Parsons", "Mclaughlin", "Zimmerman", "French", "Buchanan", "Moran", "Copeland", "Roy", "Pittman", "Brady", "Mccormick", "Holloway", "Brock", "Poole", "Frank", "Logan", "Owen", "Bass", "Marsh", "Drake", "Wong", "Jefferson", "Park", "Morton", "Abbott", "Sparks", "Patrick", "Norton", "Huff", "Clayton", "Massey", "Lloyd", "Figueroa", "Carson", "Bowers", "Roberson", "Barton", "Tran", "Lamb", "Harrington", "Casey", "Boone", "Cortez", "Clarke", "Mathis", "Singleton", "Wilkins", "Cain", "Bryan", "Underwood", "Hogan", "Mckenzie", "Collier", "Luna", "Phelps", "Mcguire", "Allison", "Bridges", "Wilkerson", "Nash", "Summers", "Atkins", "Wilcox", "Pitts", "Conley", "Marquez", "Burnett", "Richard", "Cochran", "Chase", "Davenport", "Hood", "Gates", "Clay", "Ayala", "Sawyer", "Roman", "Vazquez", "Dickerson", "Hodge", "Acosta", "Flynn", "Espinoza", "Nicholson", "Monroe", "Wolf", "Morrow", "Kirk", "Randall", "Anthony", "Whitaker", "Oconnor", "Skinner", "Ware", "Molina", "Kirby", "Huffman", "Bradford", "Charles", "Gilmore", "Dominguez", "Oneal", "Bruce", "Lang", "Combs", "Kramer", "Heath", "Hancock", "Gallagher", "Gaines", "Shaffer", "Short", "Wiggins", "Mathews", "Mcclain", "Fischer", "Wall", "Small", "Melton"]

topHackagePackages :: [Text]
topHackagePackages =
     ["egison", "timeplot", "sbv", "HTTP", "conduit", "hledger-web", "resourcet", "shakespeare", "relational-query", "hledger", "lens", "containers", "scientific", "cblrepo", "aeson", "semigroupoids", "persistent-template", "text", "http-client", "Cabal", "base", "haskell-src-meta", "scotty", "diagrams-contrib", "pandoc", "wai-routes", "cuda", "type-natural", "cabal-install", "attoparsec", "either", "pontarius-xmpp", "hlint", "git-annex", "binary", "protocol-buffers", "warp", "network", "purescript", "rainbow", "uhc-util", "github", "ncurses", "tls", "yaml", "preamble", "persistent-sqlite", "safecopy", "haskell-src-exts", "time", "QuickCheck", "rethinkdb", "repa-io", "snaplet-fay", "bamboo", "uhc-light", "hoogle", "constraints", "shake", "shellmate", "HDBC-mysql", "fltkhs", "repa-algorithms", "hspec", "protocol-buffers-descriptor", "semigroups", "threepenny-gui", "secp256k1", "friday", "persistent-postgresql", "rethinkdb-client-driver", "streaming-bytestring", "highlighting-kate", "RSA", "haskell-docs", "persistent", "random-fu", "vector", "shakers", "yaml-light-lens", "sandi", "yesod", "conduit-extra", "http-conduit", "directory", "gl", "hakyll", "hint", "simple-effects", "OpenGLRaw", "blaze-html", "computational-algebra", "hmatrix", "pointfree", "unordered-containers", "cabal2nix", "wai", "distributive", "rest-client", "rest-happstack", "YamlReference", "sdl2", "yesod-core", "zlib", "haskeline", "texmath", "Unique", "legion", "rainbox", "damnpacket", "quickcheck-instances", "wolf", "criterion", "cryptonite", "transformers", "wai-extra", "OpenGL", "Win32", "darcs", "heckle", "lzma-conduit", "yesod-bin", "cabal-rpm", "llvm-general", "pureMD5", "purescript-bridge", "sendfile", "ghc-mod", "machinecell", "lentil", "pipes", "postgresql-libpq", "shelly", "crypto-enigma", "liquid-fixpoint", "pandoc-citeproc", "rest-snap", "time-exts", "HUnit", "extra", "hashable", "irc-core", "phoityne-vscode", "pretty-show", "web3", "alex", "http-api-data", "streaming-commons", "case-insensitive", "cpphs", "dlist", "resolve-trivial-conflicts", "GLURaw", "cairo", "pretty-simple", "bifunctors", "GLUT", "MagicHaskeller", "aeson-schema", "breve", "llvm-extra", "parsec", "haddock", "pandoc-types", "prednote", "repa", "cabal-macosx", "classy-prelude", "cmdargs", "gloss", "json-rpc-server", "vector-instances", "gi-javascriptcore", "snap", "RepLib", "bytestring", "seqloc", "RefSerialize", "fast-tags", "mtl", "ALUT", "hledger-irr", "ideas", "liquidhaskell", "rattletrap", "safe", "one-liner", "pusher-http-haskell", "xml-conduit", "yesod-paginator", "esqueleto", "idris", "pdf-slave", "ply-loader", "qr-imager", "tagsoup", "ixmonad", "scalpel", "enumerator", "hslogger", "postgresql-simple", "vector-binary-instances", "yesod-auth", "amazonka", "cereal", "cryptohash", "ghcjs-dom", "hedis", "http2", "lambdacube-gl", "systemd", "al", "alex-meta", "glib", "happstack-server", "rest-types", "tagged", "vivid", "aws", "conduit-combinators", "hashable-extras", "lambda-options", "relational-query-HDBC", "snap-core", "uuid", "RNAlien", "singletons", "intro", "syb", "fgl", "linear", "memory", "rasa", "yi", "cmark", "halive", "happy-meta", "heist", "monad-control", "monad-logger", "trifecta", "Hoed", "MonadRandom", "blaze-builder", "hashed-storage", "hjsonschema", "jsaddle", "relational-record", "time-patterns", "unlit", "comonad", "distributed-process", "ginger", "reroute", "Crypto", "hspec-core", "octane", "vty", "x509", "HaXml", "JuicyPixels", "air", "concurrent-machines", "fclabels", "heyefi", "rest-wai", "hashtables", "machines-io", "xmonad", "SHA", "cgi", "free", "tar", "LDAP", "http-types", "instrument-chord", "lifted-base", "range-set-list", "references", "rss", "Agda", "ShellCheck", "ad", "blaze-markup", "classy-prelude-yesod", "clckwrks", "pango", "parallel", "postgresql-binary", "semver", "aeson-extra", "clit", "data-msgpack", "hslua", "hspec-expectations", "json-rpc-client", "language-javascript", "publicsuffix", "securemem", "stm", "HsOpenSSL", "X11", "air-extra", "contravariant", "file-embed", "interlude-l", "liblawless", "mime-mail", "pretty", "pwstore-fast", "result", "yesod-form", "bloodhound", "c2hs", "derive", "diagrams-lib", "llvm-general-pure", "polyparse", "template-haskell", "zip-archive", "deepseq", "foldl", "haskell-tools-ast", "hindent", "hxt", "network-carbon", "profunctors", "quickcheck-io", "abcnotation", "amazonka-core", "amqp", "brainfuck-tut", "digestive-functors", "glabrous", "gtk", "gtk2hs-buildtools", "language-puppet", "modular-arithmetic", "primitive", "ratel", "reedsolomon", "reflection", "reform-happstack", "stack", "up", "Chart", "alea", "amazonka-s3-streaming", "cabal-debian", "fast-logger", "hledger-lib", "hspec-discover", "jsaddle-dom", "legion-discovery", "nanovg", "unix", "wave", "biosff", "cpsa", "djinn", "ekg", "gi-gio", "haskell-tools-refactor", "haskell-tools-rewrite", "hscolour", "legion-extra", "marvin", "marvin-interpolate", "optparse-applicative", "process", "protolude", "reform-hsp", "rose-trees", "snap-server", "staversion", "test-framework", "unix-compat", "vector-space", "Yampa", "ajhc", "amazonka-s3", "cgrep", "codex", "foldl-statistics", "haste-compiler", "mongoDB", "mono-traversable", "multifile", "relational-schemas", "xmobar", "dns", "generic-deriving", "glirc", "lens-aeson", "microlens-aeson", "pcre-light", "pretty-types", "redis-io", "reform", "MissingH", "gopher-proxy", "haddocset", "haskell-tools-prettyprint", "hledger-diff", "rabocsv2qif", "regex-tdfa", "tasty-ant-xml", "terminfo", "wai-app-static", "wxcore", "xml-html-conduit-lens", "XMLParser", "array", "cassava", "graphviz", "hoopl", "hspec-meta", "leksah", "libsystemd-journal", "observable-sharing", "sbp", "th-orphans", "unidecode", "warp-tls", "arbtt", "brick", "ghc-prof", "hamlet", "haskell-tools-backend-ghc", "hbro", "http-client-tls", "lifted-async", "pinboard", "pipes-network", "project-template" ]
