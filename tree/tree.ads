package Tree is

  type Operand is new Integer;

  type Node is private;

  Empty : constant Node;

  function Evaluate (Root : Node) return Operand with
    Pre => (Root /= Empty); -- Can't possibly evaluate an empty tree.

private

  --  Totally convoluted OOP version, expanded upon Luke A. Guest's original solution.

  type Node_Data is abstract tagged null record; -- "abstract", so we never allow empty nodes.

  type Node is access constant Node_Data'Class;

  Empty : constant Node := null;

  type Operand_Node is new Node_Data with
    record
      The_Operand : Operand;
    end record;

  type Operator_Node is abstract new Node_Data with
    record
      Left_Child  : Node;
      Right_Child : Node;
    end record with Dynamic_Predicate => (Left_Child /= null and Right_Child /= null);

  function Execute (This  : in Operator_Node;
                    Left  : in Operand;
                    Right : in Operand) return Operand is abstract;

  type Operator_Add is new Operator_Node with null record;

  overriding function Execute (This  : in Operator_Add;
                               Left  : in Operand;
                               Right : in Operand) return Operand;

  type Operator_Subtract is new Operator_Node with null record;

  overriding function Execute (This  : in Operator_Subtract;
                               Left  : in Operand;
                               Right : in Operand) return Operand;

  type Operator_Multiply is new Operator_Node with null record;

  overriding function Execute (This  : in Operator_Multiply;
                               Left  : in Operand;
                               Right : in Operand) return Operand;

  type Operator_Divide is new Operator_Node with null record;

  overriding function Execute (This  : in Operator_Divide;
                               Left  : in Operand;
                               Right : in Operand) return Operand;

end Tree;
