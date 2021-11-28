template<class Type>
class closeHashTable:public hashTable<Type>{
public:
    student * array;                //存放学生的哈希表
    int size;                       //学生数量
    int(*key)(const Type x);        //哈希函数指针
public:
    closeHashTable(int length, int(*f)(const Type x));      //哈希函数的构造函数
    bool insert(const Type & x);        //将学生插入到哈希表的指定位置
    bool remove(const Type & x);        //在哈希表中对指定学生作删除标记
    bool find(const Type & x) const;    //在哈希表中寻找是否有指定学生
    void rehash();                      //彻底删除哈希表中有删除标记的学生
    int getSize(){return size;}         //返回学生个数
};


//初始化哈希表
template<class Type>
closeHashTable<Type>::closeHashTable(int length, int(*f)(const Type x))
{   size = length;
    array = new student[length];
    key = f;
}

template<class Type>
bool closeHashTable<Type>::insert(const Type &x) {
    int initPos,pos;
    initPos = pos = key(x);
    static int num = 0;
    do{

        if(array[pos].getState() != 1)          //当哈希表该位置为空时直接插入该学生，返回插入成功
        {
            array[pos].setName(x.getName());
            array[pos].changeState(1);xu
            num ++;
            return true;
        }

        //当该学生已在哈希表中，则不重复插入，返回插入成功
        if(array[pos].getState() == 1 && strcmp(array[pos].getName(),x.getName()) == 0)
            return true;

        pos = (pos + 1) % size;

    }while(pos != initPos);         //当该学生没有地方可以放下时，返回插入失败
    return false;
}


template <class Type>
bool closeHashTable<Type>::remove(const Type & x){
    int initpos,pos;
    initpos = pos =key(x);
    do{
        if(array[pos].getState() == 0)   return false;          //当删除的位置节点为空时，返回插入失败
        if(array[pos].getState() == 1 && strcmp(array[pos].getName(),x.getName()) == 0)
        {array[pos].changeState(2);  return true;}      //当需要删除的节点存在且姓名匹配时，对其做上删除标记，并返回删除成功
        pos = (pos + 1) % size;
    }while(pos != initpos);         //当该节点已被删除时，寻找下一个节点，若一圈后都没找到，返回删除失败
    return false;
}


template <class Type>
bool closeHashTable<Type>::find(const Type &x) const {
    int initpos,pos;
    initpos = pos = key(x);
    do{
        if(array[pos].getState() == 0) return false;        //当该位置为空时，返回寻找失败
        if(array[pos].getState() == 1 )                     //当该位置不为空且名字匹配时，返回寻找成功
        {
            const student tmp = array[pos];
            if( strcmp(tmp.getName(), x.getName()) == 0)
            return true;
        }
        pos = (pos + 1) % size;         //当该节点已被删除，则查找他的下一个节点
    }while(pos != initpos);             //若一圈后还未找到，则返回查找失败
    return false;
}


template<class Type>
void closeHashTable<Type>::rehash(){
    student * tmp = array;
    array = new student[size];
    for(int i = 0; i < size; i++)
    {   int state = tmp[i].getState();      //新建哈希表，将没被删除的节点插入到新表中，并用新表代替旧表
        if(state == 1)
            insert(tmp[i]);
    }
    delete tmp;
}
