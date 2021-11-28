template<class Type>
class hashTable{                                //建立哈希表的父类，规定其在派生类中必须实现的操作
public:
    virtual bool find(const Type & x) const= 0;
    virtual bool insert(const Type & x) = 0;
    virtual bool remove(const Type & x) = 0;
};
