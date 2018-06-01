# include <stdio.h>
# include <stdlib.h>
# include <string.h>


typedef unsigned int UINT;
typedef unsigned char UCHAR;
typedef unsigned short USHORT;
typedef struct node
{
    long    w;
    short   p, l, r;
}htnode, * htnp;
typedef struct huffman_code
{
    UCHAR len;
    UCHAR  *codestr;
}hufcode;
# define OK       1
# define ERROR   -1
# define UNUSE   -1
# define SELECTED -2
# define ARGS_ERR    -2
# define FILE_ERR    -3
# define HEAD_ERR    -4
# define MALLOC_ERR  -5
# define HUFTREE_ERR -6
# define HUFCODE_ERR -7
# define CHAR_BITS   8
# define INT_BITS    32
# define CODE_SIZE   256
# define CACHE_SIZE  256
# define UINT_SIZE   sizeof(UINT)
# define UCHAR_SIZE  sizeof(UCHAR)
# define USHORT_SIZE sizeof(USHORT)
# define ZIP_HEAD    0xFFFFFFFF
# define MAX_NAME_LEN    512

UCHAR   chars_to_bits(const UCHAR chars[CHAR_BITS]);
int     search_set(htnp ht, int n);
int     create_huffmantree(long w[], int n, htnode ht[]);
int     encode_huffmantree(htnp htp, int n, hufcode hc[]);
long    calc_data_frequency(FILE * in, long frequency[]);
int     compress(char * source_filename, char * obj_filename);
int     c_initial_files(char * source_filename, FILE **inp, char * obj_filename, FILE **outp);
int     write_compress_file(FILE * in, FILE * out, htnp ht, hufcode hc[], char * source_filename, long source_filesize);
void    get_mini_huffmantree(FILE * in, short mini_ht[][2]);
int     decompress(char * source_filename, char * obj_filename);
int     d_initial_files(char *source_filename, FILE **inp, char * obj_filename, FILE ** outp);
int     write_decompress_file(FILE * in, FILE * out, short mini_ht[][2], long bits_pos, long obj_filesize);
void    print_help();
void    process_error(int error_code);
void    process_args(char * first, char * second, char * third);
char    * create_default_obj_filename(char * source_filename, char * obj_filename);

int c_initial_files(char * source_filename, FILE ** inp,char * obj_filename, FILE ** outp)
{
    char  temp_filename[MAX_NAME_LEN];
    if(source_filename == NULL)
    {
        return FILE_ERR;
    }

    if(obj_filename == NULL)
    {
        obj_filename = temp_filename;
        create_default_obj_filename(source_filename, obj_filename);
    }
    if(strcmp(source_filename, obj_filename) == 0)
    {
        return FILE_ERR;
    }
    printf("待压缩文件:%s,压缩文件:%s\n", source_filename, obj_filename);

    if(( * outp = fopen(obj_filename, "wb")) == NULL)
    {
        return FILE_ERR;
    }
    if(( * inp = fopen(source_filename, "rb")) == NULL)
    {
        return FILE_ERR;
    }

    return OK;
}

long calc_data_frequency(FILE * in, long frequency[])
{
    int     i, read_len;
    UCHAR   buf[CACHE_SIZE];
    long    filesize;

    for(i = 0; i < CODE_SIZE; i ++)
    {
        frequency[i] = 0;
    }
    fseek(in, 0L, SEEK_SET);
    read_len = CACHE_SIZE;
    while(read_len == CACHE_SIZE)
    {
        read_len = fread(buf, 1, CACHE_SIZE, in);
        for(i = 0; i < read_len; i ++)
        {
            frequency[ *(buf + i)] ++;
        }
    }
    for(i = 0, filesize = 0; i < CODE_SIZE; i ++)
    {
        filesize += frequency[i];
    }
    return filesize;
}

int search_set(htnp ht, int n)
{
    int i, x;
    for(x = 0; x < n; x ++)
    {
        if(ht[x].p == UNUSE)
            break;
    }
    for(i = x; i < n; i ++)
    {
        if(ht[i].p == UNUSE && ht[i].w < ht[x].w)
        {
            x = i;
        }
    }
    ht[x].p = SELECTED;
    return x;
}

int create_huffmantree(long w[], int n, htnode ht[])
{
    int m, i, s1, s2;
    if (n < 1)    return HUFTREE_ERR;
    m = 2 * n - 1;
    if (ht == NULL)
        return HUFTREE_ERR;
    for(i = 0; i < n; i ++)
    {
        ht[i].w = w[i], ht[i].p = ht[i].l = ht[i].r = UNUSE;
    }
    for(;i < m; i ++)
    {
        ht[i].w = ht[i].p = ht[i].l = ht[i].r = UNUSE;
    }
    for(i = n; i < m; i ++)
    {
        s1 = search_set(ht, i);
        s2 = search_set(ht, i);
        ht[s1].p = ht[s2].p = i;
        ht[i].l = s1, ht[i].r = s2;
        ht[i].w = ht[s1].w + ht[s2].w;
    }
    return OK;
}

int encode_huffmantree(htnp htp, int n, hufcode hc[])
{
    int i, j, p, codelen;
    UCHAR * code = (UCHAR * )malloc(n * UCHAR_SIZE);

    if (code == NULL)
        return MALLOC_ERR;
    for(i = 0; i < n; i ++)
    {
        for(p = i, codelen = 0; p != 2 * n - 2; p = htp[p].p, codelen ++)
        {
            code[codelen] = (htp[htp[p].p].l == p ? 0:1);
        }
        if((hc[i].codestr = (UCHAR * )malloc((codelen)*UCHAR_SIZE)) == NULL)
        {
            return MALLOC_ERR;
        }
        hc[i].len = codelen;
        for(j = 0; j < codelen; j ++)
        {
            hc[i].codestr[j] = code[codelen - j - 1];
        }
    }
    free(code);
    return OK;
}

UCHAR chars_to_bits(const UCHAR chars[CHAR_BITS])
{
    int i;
    UCHAR bits = 0;

    bits |= chars[0];
    for(i = 1; i < CHAR_BITS; ++ i)
    {
        bits <<= 1;
        bits |= chars[i];
    }
    return bits;
}

int write_compress_file(FILE * in, FILE * out, htnp ht, hufcode hc[], char * source_filename, long source_filesize)
{
    UINT    i, read_counter, write_counter, zip_head = ZIP_HEAD;
    UCHAR   write_char_counter, code_char_counter, copy_char_counter, read_buf[CACHE_SIZE],
    write_buf[CACHE_SIZE], write_chars[CHAR_BITS], filename_size = strlen(source_filename);
    hufcode * cur_hufcode;
    fseek(in, 0L, SEEK_SET);
    fseek(out, 0L, SEEK_SET);
    fwrite(&zip_head, UINT_SIZE, 1, out);
    fwrite(&filename_size, UCHAR_SIZE, 1, out);
    fwrite(source_filename, sizeof(char), filename_size, out);
    fwrite(&source_filesize, sizeof(long), 1, out);
    for(i = CODE_SIZE; i < CODE_SIZE * 2 - 1; i ++)
    {
        fwrite(&(ht[i].l), sizeof(ht[i].l), 1, out);
        fwrite(&(ht[i].r), sizeof(ht[i].r), 1, out);
    }
    write_counter = write_char_counter = 0;
    read_counter = CACHE_SIZE;
    while(read_counter == CACHE_SIZE)
    {
        read_counter = fread(read_buf, 1, CACHE_SIZE, in);
        for(i = 0; i < read_counter; i ++)
        {
            cur_hufcode = &hc[read_buf[i]];
            code_char_counter = 0;
            while(code_char_counter != cur_hufcode->len)
            {
                copy_char_counter =  (CHAR_BITS - write_char_counter > cur_hufcode->len - code_char_counter ?
                                    cur_hufcode->len - code_char_counter : CHAR_BITS - write_char_counter);
                memcpy(write_chars + write_char_counter, cur_hufcode -> codestr + code_char_counter, copy_char_counter);
                write_char_counter += copy_char_counter;
                code_char_counter += copy_char_counter;
                if(write_char_counter == CHAR_BITS)
                {
                    write_char_counter = 0;
                    write_buf[write_counter ++] = chars_to_bits(write_chars);
                    if(write_counter == CACHE_SIZE)
                    {
                        fwrite(write_buf, 1, CACHE_SIZE, out);
                        write_counter = 0;
                    }
                }
            }
        }
    }
    fwrite(write_buf, 1, write_counter, out);
    if(write_char_counter != 0)
    {
        write_char_counter = chars_to_bits(write_chars);
        fwrite(&write_char_counter,1,1,out);
    }
    return OK;
}

int compress(char * source_filename, char * obj_filename)
{
    FILE * in, * out;
    int error_code, i;
    hufcode hc[CODE_SIZE];
    htnode  ht[CODE_SIZE * 2-1];
    long frequency[CODE_SIZE ], source_filesize, obj_filesize=0;
    error_code = c_initial_files(source_filename, &in, obj_filename, &out);
    if(error_code != OK)
    {
        return error_code;
    }
    puts("文件打开成功,开始读取文件信息...");
    source_filesize = calc_data_frequency(in, frequency);
    puts("文件读入完成，开始分析文件信息...");
    printf("文件大小 %ld 字节\n", source_filesize);
    error_code=create_huffmantree(frequency, CODE_SIZE, ht);
    if(error_code!=OK)
    {
        return error_code;
    }
    puts("哈夫曼树建立成功，开始哈夫曼编码...");
    error_code=encode_huffmantree(ht,CODE_SIZE,hc);
    if(error_code!=OK)
    {
        return error_code;
    }
    for(i = 0; i < CODE_SIZE; i ++)
        obj_filesize += frequency[i]*hc[i].len;
    obj_filesize = obj_filesize % 8 == 0 ? obj_filesize / 8 : obj_filesize / 8+1;
    for(i = 0; i < CODE_SIZE - 1; i ++)
        obj_filesize += 2 * sizeof(short);
    obj_filesize += strlen(source_filename) + 1;
    obj_filesize += sizeof(long);
    obj_filesize += UINT_SIZE;
    puts("编码成功，开始生成压缩文件...");
    printf("压缩文件预期长度:%ld字节,压缩比例:%.2f%%\n", obj_filesize, (float)obj_filesize / source_filesize * 100);
    error_code = write_compress_file(in, out, ht, hc, source_filename, source_filesize);
    if(error_code != OK)
    {
        return error_code;
    }
    puts("压缩完成!");
    fclose(in);
    fclose(out);
    for(i=0; i < CODE_SIZE; i ++)
    {
        free(hc[i].codestr);
    }
    return OK;
}

int d_initial_files(char * source_filename, FILE ** inp, char * obj_filename, FILE ** outp)
{
    UINT    zip_head;
    UCHAR   filename_size;
    char  temp_filename[MAX_NAME_LEN];
    printf("待解压缩文件:%s,", source_filename);
    if (( * inp=fopen(source_filename, "rb")) == NULL)
    {
        return FILE_ERR;
    }
    fread(&zip_head, UINT_SIZE, 1, * inp);
    if(zip_head != ZIP_HEAD)
    {
        return HEAD_ERR;
    }
    if(obj_filename == NULL)
    {
        obj_filename = temp_filename;
        fread( & filename_size, UCHAR_SIZE, 1, * inp);
        fread(obj_filename, sizeof(char), filename_size, * inp);
        obj_filename[filename_size] = '\0';
    }
    else
    {
        fread( & filename_size, UCHAR_SIZE, 1, * inp);
        fseek( * inp, filename_size, SEEK_CUR);
    }
    printf("解压缩文件:%s\n", obj_filename);
    if(( * outp = fopen(obj_filename, "wb")) == NULL)
    {
        return FILE_ERR;
    }
    return OK;
}

void get_mini_huffmantree(FILE * in, short mini_ht[][2])
{
    int i;
    for(i = 0; i < CODE_SIZE; i ++)
    {
        mini_ht[i][0] = mini_ht[i][1] = UNUSE;
    }
    fread(mini_ht[i], sizeof(short), 2 * (CODE_SIZE-1), in);
}

int write_decompress_file(FILE * in, FILE * out, short mini_ht[][2], long bits_pos, long obj_filesize)
{
    long    cur_size;
    UCHAR   read_buf[CACHE_SIZE], write_buf[CACHE_SIZE], convert_bit;
    UINT    read_counter, write_counter, cur_pos;

    fseek(in, bits_pos, SEEK_SET);
    fseek(out, 0L, SEEK_SET);
    read_counter = CACHE_SIZE - 1;
    cur_size = write_counter = 0;
    cur_pos = CODE_SIZE * 2 - 2;
    while(cur_size != obj_filesize)
    {
        if(++ read_counter == CACHE_SIZE)
        {
            fread(read_buf, 1, CACHE_SIZE, in);
            read_counter = 0;
        }
        for(convert_bit = 128; convert_bit != 0; convert_bit >>= 1)
        {
            cur_pos = ((read_buf[read_counter]&convert_bit) == 0 ? mini_ht[cur_pos][0]:mini_ht[cur_pos][1]);
            if(cur_pos < CODE_SIZE)
            {
                write_buf[write_counter] = (UCHAR)cur_pos;
                if(++ write_counter == CACHE_SIZE)
                {
                    fwrite(write_buf, 1, CACHE_SIZE, out);
                    write_counter = 0;
                }
                cur_pos = CODE_SIZE * 2 - 2;
                if(++ cur_size == obj_filesize)
                {
                    break;
                }
            }
        }
    }
    fwrite(write_buf, 1, write_counter, out);
    return OK;
}

int decompress(char * source_filename, char * obj_filename)
{
    int     error_code;
    FILE    * in, * out;
    short   mini_ht[CODE_SIZE * 2 - 1][2];
    long    obj_filesize;
    error_code = d_initial_files(source_filename, & in, obj_filename, & out);
    if(error_code != OK)
    {
        return error_code;
    }
    puts("文件打开成功,开始读取文件信息...");
    fread( & obj_filesize, sizeof(long), 1, in);
    printf("解压文件预期长度:%ld\n", obj_filesize);
    puts("开始重建哈夫曼树...");
    get_mini_huffmantree(in,mini_ht);
    puts("哈夫曼树建立成功，开始解压缩...");
    error_code = write_decompress_file(in, out, mini_ht, ftell(in), obj_filesize);
    if(error_code != OK)
    {
        return error_code;
    }
    puts("解压缩完成!");
    fclose(in);
    fclose(out);
    return OK;
}

char * create_default_obj_filename(char * source_filename, char * obj_filename)
{
    char * temp;
    if((temp=strrchr(source_filename, '.')) == NULL)
    {
        strcpy(obj_filename, source_filename);
        strcat(obj_filename, ".cmpfile");
    }
    else
    {
        strncpy(obj_filename, source_filename, temp-source_filename);
        obj_filename[temp-source_filename] = '\0';
        strcat(obj_filename, ".cmpfile");
    }
    return obj_filename;
}

void print_help()
{
    puts("\n压缩或者解压缩单个文件\n");
    puts("compress [-h]");
    puts("compress [-c]|[-d] source_file [object_file]\n");
    puts("  -h\t\t显示帮助信息");
    puts("  -c\t\t压缩文件");
    puts("  -d\t\t解压缩文件");
    puts("  source_file\t源文件(包括路径)");
    puts("  object_file\t目标文件(包括路径)");
}

void process_error(int error_code)
{
    switch(error_code)
    {
        case ARGS_ERR:      puts("ERR:错误的参数!");break;
        case FILE_ERR:      puts("ERR:打开文件出错!");break;
        case HEAD_ERR:      puts("ERR:非法的压缩文件头!");break;
        case MALLOC_ERR:    puts("ERR:内存分配出错!");break;
        case HUFTREE_ERR:   puts("ERR:哈夫曼生成树出错!");break;
        case HUFCODE_ERR:   puts("ERR:哈夫曼编码出错!");break;
        default:            break;
    }
}

void process_args(char * first, char * second, char * third)
{
    if (strcmp(first, "-h")==0||strcmp(first, "-?")==0)
    {
        print_help();
    }
    else if(strcmp(first, "-c")==0)
    {
        process_error(compress(second, third));
    }
    else if(strcmp(first, "-d")==0)
    {
        process_error(decompress(second, third));
    }
    else
    {
        process_error(ARGS_ERR);
    }
}

int main(int argc, char * argv[])
{
    switch(argc)
    {
        case    1:  print_help(); break;
        case    2:  process_args(argv[1], NULL, NULL); break;
        case    3:  process_args(argv[1], argv[2], NULL); break;
        case    4:  process_args(argv[1], argv[2], argv[3]); break;
        default :   process_error(ARGS_ERR);
    }
    return OK;
}

