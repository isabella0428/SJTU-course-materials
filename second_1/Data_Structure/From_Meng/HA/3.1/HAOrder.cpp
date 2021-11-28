void bubbleSort(int * data, int num)            //冒泡排序
{   int tmp;
    bool flag = true;
    int moves = 0;
    int comp = 0;
    int num1,num2;
    for(int i = 0;i < num; i++)
    {   flag = true;
        tmp = data[i];
        for(int j = 0; j< num - i; j++)
        {   comp ++;                            //从左到右冒泡
            if(data[j] > data[j+1])
            {   num1 = data[j];
                num2 = data[j+1];
                tmp = data[j];
                data[j] = data[j+1];
                data[j+1] = tmp;
                moves += 3;
                flag = false;
            }
        }
        if(flag) break;                     //若在一次起泡过程中没有出现交换现象则代表排序结束
    }
    cout<<"Bubble Sort       : compare times: "<<comp<<" moves: "<<moves<<endl;
}


void simpleInsertSort(int * data, int num)      //简单插入排序
{
    int tmp;
    int i,k;
    int moves = 0;
    int comp = 0;
    for(i = 1;i < num; i++)
    {
        tmp = data[i];                                  //按顺序将每个值插入到对应的位置
        for(k = i-1; tmp < data[k] && k >= 0; k--)
        {
            data[k+1] = data[k];
            moves ++;
            comp ++;
        }
        data[k] = tmp;
    }
    cout<<"Simple Insert Sort: compare times: "<<comp<<" moves: "<<moves<<endl;
}


void simpleSelectSort(int * data, int num)          //简单选择排序
{
    int tmp;
    int loc = -1;
    int val;
    int moves = 0;
    int comp = 0;
    for(int i = 0; i < num; i++)
    {
        tmp = data[i];                              //每次选择最小的插入到对应位置
        for(int j = i + 1; j < num; j++)
        {   comp ++;
            if(data[j] < tmp)
            {
                tmp = data[j];
                loc = j;
            }
        }
        val = data[i];
        data[i] = tmp;
        data[loc] = val;
        if(loc != i) moves += 3;
    }
    cout<<"Simple Select Sort: compare times: "<<comp<<" moves: "<<moves<<endl;
}










int divide(int * data, int low, int high,int & comp, int & moves)
{
    int tmp = data[low];
    while(low < high)             //将数组元素按数组最低位对应的数值排序，左边比它小，右边比它大
    {
        while(low < high && data[high] >= tmp)
        { high --; comp ++;}
        comp ++;
        if(low < high)
        {
            data[low] = data[high];
            moves ++;
        }

        while(data[low] <= tmp && low < high)
        {low ++; comp ++;}
        if(low < high)
        {
            data[high] = data[low];
            moves ++;
        }
    }
    data[low] = tmp;
    moves ++;
    return low;
}


void quickSort(int * data, int low, int high,int & comp, int & moves)   //递归实现快速排序
{
    int mid;
    comp ++;
    if(low >= high) return;

    mid = divide(data, low, high, comp, moves);
    quickSort(data, mid + 1, high, comp, moves);
    quickSort(data, low, mid - 1, comp, moves);

}


void quickSort(int * data, int num)             //快速排序的外部接口
{   int comp = 0;
    int moves = 0;
    quickSort(data, 0 ,num - 1, comp, moves);
    cout<<"Quick Sort        : compare times: "<<comp<<" moves: "<<moves<<endl;
}


void shellSort(int * data, int num)             //希尔排序
{
    int tmp;
    int i,j;
    int comp = 0;
    int moves = 0;
    for(int step = num / 2; step > 0; step /= 2)        //变间隔排序
    {
        for(i = step; i < num; i++)
        {
            tmp = data[i];
            for(j = i - step; j > 0 && tmp > data[j]; j -= step)
            {
                data[j + step] = data[j];
                moves ++;
                comp ++;
            }
            data[j] = tmp;

        }
    }
    cout<<"Shell Sort        : compare times: "<<comp<<" moves: "<<moves<<endl;
}


void percolate(int * data, int hole, int num, int & comp, int & moves)
{
    int child;
    int tmp = data[hole];

    while(hole * 2 + 1 < num)           //保证堆顶元素是堆内最大的
    {
        child = 2 * hole + 1;
        comp += 2;
        if ( child < num - 1 && data[child + 1] > data[child])
        {
            child ++;
        }

        if(data[child] > tmp)
        {
            data[hole] = data[child];
            moves += 3;
        }
        else
            break;

        hole = child;
        moves ++;
    }
    data[hole] = tmp;
    moves ++;
}


void heapSort(int * data, int num)              //堆排序
{
    int tmp;
    int i;
    int comp = 0;
    int moves = 0;

    for(int i = num / 2 -1; i >= 0; i--)        //建堆
        percolate(data, i ,num, comp, moves);

    for(int j = num - 1; i > 0; i--)            //堆排序
    {
        tmp = data[0];
        data[0] = data[j];
        data[j] = tmp;
        percolate(data, 0, i, comp, moves);
        moves += 3;
    }

    cout<<"Heap Sort         : compare times: "<<comp<<" moves: "<<moves<<endl;
}

