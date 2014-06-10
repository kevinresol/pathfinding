# pathfinding

A pathfinding library for Haxe

## Usage

### A*

1. Implement `INode` and `INodeManager`
2. `var aStar = new AStar(nodeManager);`
3. `var path = aStar.findPath(origin, destination);`

### HPA*

1. Implement `INode`, `INodeManager`, `ICluster`, `IClusterManager`
2. `var hpaStar = new HPAStar(level, clusterManager);`
3. `var path = hpaStar.findPath(origin, destination);`

## References

### A*

[http://en.wikipedia.org/wiki/A*_search_algorithm]
	
###HPA*:
	
[http://webdocs.cs.ualberta.ca/~mmueller/ps/hpastar.pdf]