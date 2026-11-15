/*
 *  Verifies the results of the mux, exits with a 0 on success.
 */

#include "base_testbench.h"
#include <fstream>
#include <iostream>

Vdut *top;
VerilatedVcdC *tfp;
unsigned int ticks = 0;
unsigned int expected_instruction = 0;

void load_expected_instruction(const char *filename, unsigned int address)
{
    std::ifstream program_file(filename);

    if (!program_file) {
        std::cerr << "Could not open " << filename << "\n";
        std::exit(1);
    }

    unsigned int byte;
    unsigned int current_address = 0;

    while (program_file >> std::hex >> byte) {
        if (current_address == address) {
            unsigned int byte0 = byte;

            program_file >> std::hex >> byte;
            unsigned int byte1 = byte;

            program_file >> std::hex >> byte;
            unsigned int byte2 = byte;

            program_file >> std::hex >> byte;
            unsigned int byte3 = byte;

            expected_instruction =
                byte0 |
                (byte1 << 8) |
                (byte2 << 16) |
                (byte3 << 24);

            return;
        }

        current_address++;
    }

    std::cerr << "Could not read instruction at address "
              << address << "\n";
    std::exit(1);
}

class ROMTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->addr = 0;
        // output: out
    }
};

TEST_F(ROMTestbench, ADDR0_ROMTEST)
{
    top->addr = 0;
    load_expected_instruction("../rtl/program.hex", 0);
    top->eval();

    EXPECT_EQ(top->instruc, expected_instruction);
}

TEST_F(ROMTestbench, MEGA_ROMTEST)
{
    int NUM_INSTR = 7;
    for (int i=1; i<NUM_INSTR; i++) {
        int byte_addr = i * 4;
        load_expected_instruction("../rtl/program.hex", byte_addr);
        top->addr = byte_addr;
        top->eval();
        EXPECT_EQ(top->instruc, expected_instruction);
    }
}

int main(int argc, char **argv)
{
    top = new Vdut;
    tfp = new VerilatedVcdC;

    Verilated::traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");

    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();

    top->final();
    tfp->close();

    delete top;
    delete tfp;

    return res;
}
