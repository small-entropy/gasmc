package cli

import (
	"fmt"

	"github.com/spf13/cobra"
)

func init() {
	rootCmd.AddCommand(versionCmd)
}

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version of number of GASM Compiler",
	Long:  "All software has version. This is GASM Complier's",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Gefal Assembler bytecode compiler v0.0.1 -- HEAD")
	},
}
