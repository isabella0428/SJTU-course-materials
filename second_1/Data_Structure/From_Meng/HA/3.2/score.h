class list{
    struct student{                     //私有结构体
        int score[6];                   //六科成绩，分别对应课程0，课程1...
        int total = 0;                  //六科成绩总分

        student() {                     //构造函数，随机生成六科成绩并计算出总分
            for(int i = 0; i < 6; i++)
            { score[i] = rand() % 101;
            total += score[i]; }
        }
    };

    int num = 0;                        //学生名数
    student * records;                  //学生成绩汇总矩阵
    int priority[6];                    //单科成绩优先级，数组中序号最小的学科优先级最高

public:
    list();                             //构造函数
    ~list();                            //析构函数

public:
    void quickSort();                               //快速排序外部接口
    void quickSort(int low, int high);              //快速排序内部接口（递归实现）
    bool Compare(student A, student B);             //两学生总分比较
    bool Compare(student A, student B,int level);   //两学生总分相同时成绩比较（递归实现）
    int divide(int low, int high);                  //根据数组中low位置对应的值排序
};


list::list()
{
    srand(unsigned((time)(NULL)));                                  //生成学生名数
    num = rand() % 100;
    cout<<"Total number of records:"<<num<<endl;
    records = new student[num];
    cout<<"Please input the subject place py their priority"<<endl;
    for(int i = 0; i < 6; i++)                                      //用户自定义输入单科成绩的优先级
        cin>>priority[i];
}


list::~list()
{   cout<<"Sorted total score!"<<endl;                              //输出排序后的总分和单科成绩
    for(int i = 0; i < num; i++)
    {cout<<records[i].total<<" ";
    for(int j = 0;j < 6;j++)
        cout<<records[i].score[j]<<" ";
    cout<<endl;}
}


bool list::Compare(student A, student B, int level)
{                                                                              //总分及各门成绩相同
    if (level == 5 && A.score[priority[level]] == B.score[priority[level]])
        return true;
    if (A.score[priority[level]] > B.score[priority[level]])                   //A单科高，返回值为true
        return true;
    if (A.score[priority[level]] < B.score[priority[level]])                   //B单科高，返回值为false
        return false;
    return Compare(A, B, level + 1);
}



bool list::Compare(student A, student B)
{
    if (A.total > B.total)                  //A总分高，返回值为true
        return true;
    if (A.total < B.total)                  //A总分低，返回值为false
        return false;
    else                                    //总分相同，比较单科成绩
       return Compare(A, B, 0);
}


int list:: divide(int low, int high)
{
    student tmp = records[low];                             //将分数按tmp的值排序

    while(low != high) {
        while(low < high && Compare(records[high],tmp) )
            high --;
        if(low < high)
            records[low] = records[high];

        while(low < high && Compare(tmp, records[low]))
            low ++;
        if(low < high)
            records[high] = records[low];
    }

    records[low] = tmp;
    return low;
}


void list::quickSort(int low, int high)          //快速排序递归实现
{
    if(low >= high) return;
    int mid = divide(low, high);
    quickSort(low, mid - 1);
    quickSort(mid + 1, high);
}


void list::quickSort()                          //快速排序外部接口
{
    quickSort(0, num - 1);
}
