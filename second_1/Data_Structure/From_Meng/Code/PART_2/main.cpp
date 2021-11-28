#include <iostream>
#include "Part.h"
#include "FuncPointer.h"
#include <fstream>
using namespace std;
ifstream in;
ofstream out;
int main() {
//    in.open("input.txt");
    cout<<"Welcome to Huffman System!"<<endl;
    cout<<"I(initialization) "<<"E(encoding) "<<"D(Decoding) "<<"P(Code Printing) "<<"T(Tree printing)"<<endl;
    char Command;
    cout<<"Please input command:"<<endl;
    cin>>Command;

    hfTree<char>* MyTree;

    hfTree<char>* (*I)()  = initial;
    void (*E)(const hfTree<char> & MyTree) = Encoding;
    void (*D)(const hfTree<char> & MyTree) = Decoding;
    void (*P)(const hfTree<char> &MyTree) = CodePrinting;
    void (*T)(const hfTree<char> & MyTree) = Treeprinting;

    int flag = false;
    while(Command != 'Q')
    {   if(Command != 'I' && flag == false)
        cout<<"Not Initialized yet!!"<<endl;
        if(Command=='I' )
        {
            MyTree = initial();
            flag = true;
            cout<<"Initialization ended!"<<endl;
        }

        if(Command == 'E'&&flag != 0 ) {
            Encoding(*MyTree);
            cout<<"Encoding ended!"<<endl;
        }


        if(Command == 'D'&&flag != 0 )
        {Decoding(*MyTree);
         cout<<"Decoding ended!"<<endl;}

        if(Command == 'P'&&flag != 0)
        {CodePrinting(*MyTree);
         cout<<"Code Printing ended!"<<endl;}

        if(Command == 'T'&&flag != 0)
        {Treeprinting(*MyTree);
        cout<<"Tree Printing Ended!"<<endl;}

        cout<<"Please input Command:"<<endl;
        cin>>Command;
    }
//    in.close();
    return 0;
}
