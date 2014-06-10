# pathfinding

A pathfinding library for Haxe

## Usage

### A*

1. Implement INode and INodeManager
2. `var aStar = new AStar(nodeManager);`
3. `aStar.findPath(origin, destination);`

### HPA*

1. Implement INode, INodeManager, ICluster, IClusterManager
2. `var hpaStar = new HPAStar(level, clusterManager);`
3. `hpaStar.findPath(origin, destination);`