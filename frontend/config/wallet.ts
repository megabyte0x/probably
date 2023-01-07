import "@rainbow-me/rainbowkit/styles.css";
import { getDefaultWallets } from "@rainbow-me/rainbowkit";
import { configureChains, createClient } from "wagmi";
import { mainnet, polygon, polygonMumbai } from "wagmi/chains";
import { alchemyProvider } from "wagmi/providers/alchemy";
import { publicProvider } from "wagmi/providers/public";

export const { chains, provider } = configureChains(
  [mainnet, polygon, polygonMumbai],
  [
    alchemyProvider({ apiKey: process.env.ALCHEMY_KEY as string }),
    publicProvider(),
  ]
);

export const { connectors } = getDefaultWallets({
  appName: "remanent-auth-dashboard",
  chains,
});

export const wagmiClient = createClient({
  autoConnect: false,
  connectors,
  provider,
});
