{
  description = "Eiros hardware configuration - vwestberg workstation";

  outputs = { nixpkgs, ... }: {
    nixosModules.default = { ... }: {
      eiros.system.hardware.cpu.vendor = "amd";
    };
  };
}
