#include <iostream>

int n, x, steps;

int main()
{
	int collatz(int x);
	
	std::cout << "Number to perform collatz: ";
	std::cin >> x;
	
	std::cout << "Collatz operations: " << collatz(x);

}

int collatz(int x)
{
	while (x != 1)
	{
		if (x % 2 == 0)
		{
			x = x / 2;
			steps++;
		}
		else
		{
			x = x * 3 + 1;
			steps++;
		}
	}
	return steps;
};