////////////////////////////////////////////////////////////////////////////
// Company:         Oregon State University
// Engineer:        Matthew Walker, Silas Waxter
//
// Create date:     06/04/2022
// Design name:     PS2ControlledSprite
// Module name:     count_ud
// Target devices:  DE10Lite
// Tool versions:   Quartus Prime Lite Edition 18.0
// Description:     Bounded counter that counts up or down by Pcount when clock is high and corresponding pos, neg is active high will stay in bounds determined by Ub and Lb.
// 
////////////////////////////////////////////////////////////////////////////

module count_ud #(parameter N = 10, Ub = 385, Lb = 0, Pcount = 6)
                 (input logic clk, 
                  input logic pos, neg,
						input logic res,
						output logic [N-1:0] q);
						
  logic [N-1:0] s_curr, s_next; //current and next state
//  logic [N-1:0] n1, n2;

  always_ff @(posedge clk, posedge res)
    if(res)
      s_curr <= Lb;
    else
      s_curr <= s_next;

	 
  always_comb
    begin
      if(res)
        s_next = Lb;
		else if(pos)
		  begin
		    if(!((s_next + Pcount) >= Ub))
	         s_next = s_curr + Pcount; 
		    else if((s_next + Pcount) > Ub)
			   s_next = Ub;
		    else 
		      s_next = s_curr;
		  end
		else if (neg)
		  begin
//		    n1 = $signed(s_next - Pcount);
//			 n2 = $signed(Lb);
          if($signed(s_next - Pcount) < $signed(Lb))
			   s_next = Lb;
			 else if($signed(s_next - Pcount) >= $signed(Lb))
			   begin
			     s_next = s_curr - Pcount;
				end
	       else
	         s_next = s_curr;
			end
	   else
	     s_next = s_curr; //pause
    end

  assign q = s_curr; //q is the output
 
endmodule
