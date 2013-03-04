package;

class Test
{
    public static function main()
    {
        trace("hello");

    }

    function addCompiles()
    {
        var test = new MacroTest();
        var typeA = new TypeA();
        test.add(typeA);
    }

//    function canAddInstance()
//    {
//        var test = new MacroTest();
//        var typeA = new TypeA();
//        test.add(typeA);
//        trace(typeA == test.get(TypeA));
//    }
//
//    function canAddConstructor()
//    {
//        var test = new MacroTest();
//        test.add(new TypeA());
//        trace(test.get(TypeA));
//    }
//
//    function canAddSubComponent()
//    {
//        var test = new MacroTest();
//        var typeB = new TypeB();
//        test.add(typeB);
//        trace(typeB == test.get(TypeB));
//    }
//
//    function canAddSubComponentAsSuper()
//    {
//        var test = new MacroTest();
//        var typeB = new TypeB();
//        test.add(typeB, TypeA);
//        trace(typeB == test.get(TypeA));
//    }
}

class TypeA
{
    public function new() {}
}

class TypeB extends TypeA
{
    public function new()
    {
        super();
    }
}