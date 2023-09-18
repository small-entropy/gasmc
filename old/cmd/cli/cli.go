package cli

import "github.com/spf13/cobra"

var rootCmd *cobra.Command

func init() {
	rootCmd = &cobra.Command{Use: "gasm-compiler"}
}

func Execute() {
	rootCmd.Execute()
}
