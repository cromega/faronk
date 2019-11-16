module LinkDetectorTest exposing (..)

import Test exposing (..)
import Expect

import LinkDetector exposing (LogPart (..), splitLine)

suite : Test
suite =
  describe "LinkDetector"
    [ describe ".splitLine"
      [ test "it splits a line by the URLs" <|
        \_ -> splitLine "foo https://bar.baz boz"
                |> Expect.equal [Text "foo ", URL "https://bar.baz", Text " boz"]
      ]
    ]
