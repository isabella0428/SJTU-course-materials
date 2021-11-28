//
// Created by Lyu Yi on 2018/11/17.
//

#ifndef PART_2_FUNCPOINTER_H
#define PART_2_FUNCPOINTER_H
#include <fstream>
#include "Part.h"
#include <string>
extern ifstream in;

hfTree<char>* initial()
{
    int n;          //num of signs
    cout<<"Please input the number of characters:"<<endl;
    cin>>n;
    cin.get();
    cout<<"Please input the characters:(no spaces)"<<endl;
    char * chars;
    chars = new char [n + 1];
    cin.getline(chars,n + 1);


    int * weights;
    weights = new int [n];
    cout<<"Please input the weights:(separated by spaces)"<<endl;
    for(int i=0;i<n;++i)
    {
        cin>>weights[i];
    }
    ofstream out2;
    out2.open("hfmTree.txt");
    hfTree<char>* MyTree = new hfTree<char>(chars,weights,n);
    out2<<"characters:"<<endl;
    for(int i=0;i<n;i++)
    {
        out2<<chars[i]<<" ";
    }
    out2<<endl;

    out2<<"weights:"<<endl;
    for(int i=0;i<n;i++)
    {out2<<weights[i]<<" ";}
    out2<<endl;

    out2<<"parents:"<<endl;
    for(int i=n;i<2*n;i++)
    {out2<<MyTree -> GetElem()[i].parent<<" ";}

    out2<<endl;
    return MyTree;
}

void Encoding(const hfTree<char> & MyTree)
{   ifstream in3;
    in3.open("plainFile.txt");
    ofstream out3;
    out3.open("codeFile.txt");
    int num = MyTree.GetLength()/2;
    hfTree<char>::hfCode result[num];
    MyTree.getCode(result);

    char now= in3.get();
    while(now!=EOF)
    {
        for(int i = 0;i<num;i++)
        {
            if(now == result[i].data)
            {out3<<result[i].Code<<" ";
            break;}
        }
        now = in3.get();
    }
    out3.close();
    in3.close();
}

void Decoding(const hfTree<char> &MyTree)
{
    ifstream in4;
    ofstream out4;
    in4.open("codeFile.txt");
    out4.open("textFile.txt");
    string cur;
    int num = MyTree.GetLength()/2;
    hfTree<char>::hfCode result[num];
    MyTree.getCode(result);

    for(int i = 0;i < MyTree.GetLength(); ++i)
    {
        getline(in4,cur,' ');
        for(int i = 0;i < MyTree.GetLength(); ++i)
        {
            if(cur == result[i].Code)
            {out4<<result[i].data; break;}
        }
    }
    in4.close();
    out4.close();
}

void CodePrinting(const hfTree<char> &MyTree)
{
    ifstream in5;
    in5.open("codeFile.txt");
    ofstream out5;
    out5.open("codePrint.txt");
    int sum = 0;
    char cur = in5.get();
    while(cur != EOF)
    {
        if(cur == ' ')
        {
            cur = in5.get();
            continue;
        }
        if(sum < 50)
        {
            cout<<cur;
            sum++;
            out5<<cur;
        }
        else
        {
            sum = 1;
            cout<<endl;
            cout<<cur;
            out5<<endl;
            out5<<cur;
        }
        cur = in5.get();
    }
    in5.close();
    out5.close();
    cout<<endl;
}

void PrintHelp (hfTree<char>::Node p,const hfTree<char> & MyTree, ofstream& out6,string ss);

void Treeprinting(const hfTree<char> & MyTree)
{
   ofstream out6;
   out6.open("treePrint.txt");
   string ss = "";
   PrintHelp(MyTree.GetElem()[1],MyTree, out6,ss);
}

void PrintHelp (hfTree<char>::Node p,const hfTree<char> & MyTree, ofstream& out6,string ss)
{
    if(p.parent != 0)
        ss += "\t";
    if (p.left == 0)
    {if (p.data != '\0')
        {out6 << ss<<p.weight << "(" << p.data << ")"<<endl;
         cout << ss<<p.weight << "(" << p.data << ")"<<endl;}
    else
        {out6 << ss<<p.weight<<endl;
         cout << ss<<p.weight<<endl;}
    return;
    }
    PrintHelp(MyTree.GetElem()[p.left], MyTree, out6,ss);
    if (p.data != '\0')
    {out6 <<ss<< p.weight << "(" << p.data << ")"<<endl;
     cout<<ss<< p.weight << "(" << p.data << ")"<<endl;}
    else
    {out6 << ss<<p.weight<<endl;
    cout<<ss<<p.weight<<endl;}
    PrintHelp(MyTree.GetElem()[p.right], MyTree, out6,ss);
}






#endif //PART_2_FUNCPOINTER_H
