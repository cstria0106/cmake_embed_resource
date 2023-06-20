#include <resources/example.h>
#include <cstring>
#include <cstdio>

void print(const char *name, const unsigned char *buffer, size_t size)
{
    printf("%s (%zd bytes)\n", name, size);
    for (int i = 0; i < size; i++)
    {
        putchar(buffer[i]);
    }
    putchar('\n');
}

int main()
{
    print("test_file.txt", EXAMPLE_RESOURCE_test_file_txt, sizeof(EXAMPLE_RESOURCE_test_file_txt));
    putchar('\n');
    print("subdir/file_in_directory.txt", EXAMPLE_RESOURCE_subdir__file_in_directory_txt, sizeof(EXAMPLE_RESOURCE_subdir__file_in_directory_txt));
}