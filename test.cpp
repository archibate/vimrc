template <class T>
struct Hello {
    void func();
    int func(int x);
};

template <class T>
int Hello<T>::func(int x)
{
}
```

```
