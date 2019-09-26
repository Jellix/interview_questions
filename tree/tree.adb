package body Tree is

  overriding function Execute (This  : in Operator_Add;
                               Left  : in Operand;
                               Right : in Operand) return Operand is (Left + Right);

  overriding function Execute (This  : in Operator_Subtract;
                               Left  : in Operand;
                               Right : in Operand) return Operand is (Left - Right);

  overriding function Execute (This  : in Operator_Multiply;
                               Left  : in Operand;
                               Right : in Operand) return Operand is (Left * Right);

  overriding function Execute (This  : in Operator_Divide;
                               Left  : in Operand;
                               Right : in Operand) return Operand is (Left / Right);

  function Evaluate (Root : Node) return Operand is
  begin
    if Root.all in Operand_Node'Class then
      -- Operand node, so return the actual operand.
      return Operand_Node (Root.all).The_Operand;
    end if;

    if Root.all in Operator_Node'Class then
      -- Operator node, evaluate it recursively.
      declare
        Op : Operator_Node'Class renames Operator_Node'Class (Root.all);
      begin
        -- Evaluate the given operator by calling Evaluate recursively.
        return Op.Execute (Evaluate (Op.Left_Child), Evaluate (Op.Right_Child));
      end;
    end if;

    raise Program_Error with "Root'Class unsupported (neither operand nor operator)!";
  end Evaluate;

end Tree;
