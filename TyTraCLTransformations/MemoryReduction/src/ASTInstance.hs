-- TEST 1
module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
       ( Vec VT (Scalar VDC DInt "v_1"), Map (Function "f1" []) (Vec VI (Scalar VDC DInt "v_0")) )
       ,(Vec VS (SVec 3 (Scalar VDC DInt "v_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DInt "v_1")))
       ,( Vec VT (Scalar VDC DInt "v_2"), Map (Function "f2" []) (Vec VS (SVec 3(Scalar VDC DInt "v_s_1"))) )
       ,(Vec VS (SVec 3 (Scalar VDC DInt "v_s_2" )) , Stencil (SVec 3 (Scalar VDC DInt "s2")) (Vec VT (Scalar VDC DInt "v_2")))
       ,( Vec VO (Scalar VDC DInt "v_3"), Map (Function "f3" []) (Vec VS (SVec 3(Scalar VDC DInt "v_s_2"))) )
        ]

functionSignaturesList = [
        ("f1",  [Tuple [],Scalar VDC DInt "v_0",Scalar VDC DInt "v_1"]),
        ("f2",  [Tuple [],SVec 3 (Scalar VDC DInt "v_s_1"),Scalar VDC DInt "v_2"]),
        ("f3",  [Tuple [],SVec 3 (Scalar VDC DInt "v_s_2"),Scalar VDC DInt "v_3"])
    ]
stencilDefinitionsList = [("s1" , [-1,0,1] ), ("s2" , [-1,0,1] )]

mainArgDeclsList = [
      ("v_0" , MkFDecl "integer"  (Just [500]) (Just In) ["v_0"] )
    , ("v_3" , MkFDecl "integer"  (Just [500]) (Just Out) ["v_3"] )
  ]
scalarisedArgsList = []
origNamesList = []

{-
v_0 :: Vec 500 Int

v_3 :: Vec 500 Int

f3 :: SVec 3 Int -> Int
f2 :: SVec 3 Int -> Int
f1 :: Int -> Int

main :: (Vec 500 Int) -> (Vec 500 Int)
main v_0 =
  let
    v_1 =  map f1 v_0
    s1 = [-1,0,1]
    v_s_1 = stencil s1 v_1
    v_2 =  map f2 v_s_1
    s2 = [-1,0,1]
    v_s_2 = stencil s2 v_2
    v_3 =  map f3 v_s_2
  in
    v_3
-}
