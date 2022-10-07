#include "minimal_core/minimal_core.h"

int main(int argc, char** argv)
{
    ActiveMinimal minimal;

    std::this_thread::sleep_for(std::chrono::seconds(1));
	
    std::cout << "Press ENTER to continue...";
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}