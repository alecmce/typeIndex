package;

#if macro
import haxe.macro.Expr;
#end

class MacroTest
{
    var hash:IntHash<Dynamic>;

    public function new()
    {
        hash = new IntHash<Dynamic>();
    }

    @:macro public function add(self:Expr, args:Array<Expr>)
    {
        var id = TypeIndex.getClassIDWithOptionalType(args);
        trace("id");
        trace(id);
        return macro $self.addWithID($id, $(args[0]));
    }

        @:keep function addWithID(id:Int, component:Dynamic)
        {
            trace(id + ": " + component);
            var isNew = hash.exists(id);
            hash.set(id, component);
            return isNew;
        }

    @:macro public function get(self:Expr, type:Expr)
    {
        return macro $self.hash.get(TypeIndex.getClassID(type));
    }

}
