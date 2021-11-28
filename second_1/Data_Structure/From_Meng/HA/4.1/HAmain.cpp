int main() {
    int num;                               //随机数个数
    int ** data;                           //随机数据生成
    srand((unsigned)time(NULL));
    for(int k = 1; k <= 5; k++) {          //进行五次试验
        num =  rand() % 10000;             //生成随机数个数

        data = new int *[6];
        for(int i = 0; i < 6;i++)
            data[i] = new int [num];

        for (int i = 0; i < num; i++)
        { data[0][i] = rand(); }

        for(int i = 1;i < 6; i++)
            for(int j = 0;j < num; j++)         //为六种排序方式分别准备随机数据
                data[i][j] = data[0][j];

        cout<<endl;
        cout << "Round " << k << ": " << endl;
        cout << "Total num: " << num << endl;
        bubbleSort(data[0], num);               //冒泡排序
        simpleInsertSort(data[1],num);          //简单插入排序
        simpleSelectSort(data[2],num);          //简单选择排序
        quickSort(data[3],num);                 //快速排序
        shellSort(data[4],num);                 //希尔排序
        heapSort(data[5], num);                 //堆排序

        for(int k = 0;k < 6;k++)                //释放内存
            delete [] data[k];
        delete data;
    }


    return 0;
}