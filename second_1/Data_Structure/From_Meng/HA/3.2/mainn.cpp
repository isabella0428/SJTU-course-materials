#define Num 30                          //定义同学个数为30

int hash1(const student A)  {           //定义采用除留余数法的哈希函数
    int sum = 0;
    for(int i = 1; i < 5; i++)
        sum += int(A.getName()[i]);
    return sum % NUM ;
}

int main() {
    ifstream in;
    in.open("name.txt");                    //读入30个人名
    int (*f)(const student A) = hash1;      //定义指向哈希函数的函数指针
    closeHashTable<student> a(30, f);       //利用默认构造函数新建对象
    char tmp[Num][20];                      //每一行代表一个同学的名字
    for(int i = 0;i < Num; i++)
    {
        in >> tmp[i];
        student A = student(tmp[i]);
        a.insert(A);                        //将同学插入到哈希表的对应位置
    }

    for(int i = 0 ; i< 30 ; i++) {
        if (a.array[i].getState() == 1)             //将未被删除的同学的名字按他们在哈希表中的位置输出
        { cout << a.array[i].getName() << endl; }
    }
        return 0;
}