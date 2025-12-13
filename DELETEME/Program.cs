using System.Runtime.CompilerServices;

namespace DELETEME.Program;

class Program
{
    static void Main(string[] Args)
    {
        List<int> grades = [12, 21, 6, 15, 30];

        // Find Grades <= 15
        IEnumerable<int> gradesQuery =
            from grade in grades
            where grade <= 15
            select grade;
        
        foreach (int grade in gradesQuery)
        {
            System.Console.WriteLine($"Grade below 15 -> {grade}");
        }
    }
}