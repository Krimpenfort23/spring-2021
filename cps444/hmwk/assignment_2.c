/**
 * Author: Evan Krimpenfort
 *
 * Project: Assignment_2.c
 */

#include <stdio.h>

/*
 * 1. What will this program print?
 *    8 8
 *    4 4
 *    0 0 
 *    2 2 
 */
void question_1()
{
  int ref[] = {8, 4, 0, 2};
  int *ptr;
  int index;

  for (index = 0, ptr = ref; index < 4; index++, ptr++)
     printf("%d %d\n", ref[index], *ptr);
}

/*
 * 2. Write a program that initializes an array-of-double and then copies the contents of the array into 
 *    three other arrays. (All four arrays should be declared in the main program.) To make the first copy, 
 *    use a function with array notation. To make the second copy, use a function with pointer notation 
 *    and pointer incrementing. Have the first two functions take as arguments the name of the target array, 
 *    the name of the source array, and the number of elements to be copied. Have the third function take 
 *    as arguments the name of the target, the name of the source, and a pointer to the element following the 
 *    last element of the source. That is, the function calls would look like this, given the following declarations:
 *
 *    double source[5] = {1.1, 2.2, 3.3, 4.4, 5.5};
 *    double target1[5];
 *    double target2[5];
 *    double target3[5];
 *    copy_arr(target1, source, 5);
 *    copy_ptr(target2, source, 5);
 *
 *    copy_ptrs(target3, source, source + 5);
 */
void copy_arr(double *target, double *source, int size)
{
	for (int i = 0; i < size; i++)
	{
		target[i] = source[i];
	}
}
void copy_ptr(double *target, double *source, int size)
{
	for (int i = 0; i < size; i++, target++, source++)
	{
		*target = *source;
	}
}
void copy_ptrs(double *target, double *source, double *source_ending_position)
{
	while (*source != *source_ending_position)
	{
		*target = *source;
		target++;
		source++;
	}
}
void print_arr(double* arr, int size)
{
	for (int i = 0; i < size; i++)
	{
		printf("%.1f\n", arr[i]);
	}
}

/*
 * 3. Write a function that returns the largest value stored in an array-of-int. Test the function in a simple program.
 */
int largest(int *arr)
{
	int largest = arr[0];

	for (int i = 1; i < sizeof(arr); i++)
	{
		if (largest < arr[i])
		{
			largest = arr[i];
		}
	}

	return largest;
}
/*
 * 4. Write a function that returns the index of the largest value stored in an array-of-double. 
 *    Test the function in a simple program.
 */
int largestIndex(double *arr)
{
	int largest_index = 0;

	for (int i = 1; i < sizeof(arr); i++)
	{
		if (arr[largest_index] < arr[i])
		{
			largest_index = i;
		}
	}

	return largest_index;
}

/*
 * 5. Write a function that returns the difference between the largest and smallest elements of an array-of-double. 
 *    Test the function in a simple program.
 */
double difference(double *arr)
{

}

/*
 * Main: where questions are ran and compiled.
 */
int main()
{
	// question 1
	question_1();

	// question 2
	double source[5] = {1.1, 2.2, 3.3, 4.4, 5.5};
	double target1[5];
	double target2[5];
	double target3[5];
	copy_arr(target1, source, 5);
	copy_ptr(target2, source, 5);
	copy_ptrs(target3, source, source+5);
	print_arr(target1, 5);
	print_arr(target2, 5);
	print_arr(target3, 5);

	// question 3
 	int question3[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4};
	printf("the largest is %d.\n", largest(question3));	

	// question 4
 	double question4[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4};
	printf("the largest index is %d.\n", largestIndex(question4));	

	return 0;
}
