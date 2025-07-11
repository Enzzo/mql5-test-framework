//+------------------------------------------------------------------+
//|                                                testframework.mqh |
//|                                                   Sergey Vasilev |
//|                                         vasilevnogliki@yandex.ru |
//+------------------------------------------------------------------+
#property copyright "Sergey Vasilev"
#property link      "vasilevnogliki@yandex.ru"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+

#include <vasilev/logger/logger.mqh>

#define RUN_TEST(func) RunTestImpl(func, #func);

#define ASSERT_HINT(expr, hint) AssertImpl((expr), #expr, __FILE__, __FUNCTION__, __LINE__, hint);
#define ASSERT(expr) ASSERT_HINT(expr, "")

#define ASSERT_EQUAL_HINT(left, right, hint) AssertEqualImpl((left), (right), #left, #right, __FILE__, __FUNCTION__, __LINE__, hint)
#define ASSERT_EQUAL(left, right) ASSERT_EQUAL_HINT(left, right, "");


typedef void (*Func)();
void RunTestImpl(Func f, const string s){
   f();
   const string msg = "Test " + s + " DONE";
   LOG(msg);
}

void AssertImpl(bool expression,
               const string str,
               const string file,
               const string function,
               const unsigned line,
               const string hint
               ){
   if (!expression) {
        string msg = file + "(" + IntegerToString(line) + "): " + function + ": ASSERT(" + str + ") failed. ";
        if (hint.Length() > 0) {
            msg += "Hint: " + hint;
        }
        LOG(msg)
        return;
    }
}

template<typename U, typename T>
void AssertEqualImpl(const U& l,
               const T& r,
               const string l_str,
               const string r_str,
               const string file,
               const string function,
               const unsigned line,
               const string hint
               ){
   if (l != r) {
        string msg = file + "(" + IntegerToString(line) + "): " + function + ": ASSERT_EQUAL(" + l_str + ", " + r_str + ") failed. ";
        if (hint.Length() > 0) {
            msg += "Hint: " + hint;
        }
        LOG(msg)
        return;
    }
}