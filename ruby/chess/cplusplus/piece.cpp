class Piece {
	public:
		string name = "generic";
		string color = "white or black";
		int pos[2];
		int * move(int * pos) {
			return pos;
		}
};

class NullPiece: public Piece {
	string name = "null";
	string color = "null";
};
