class ManagerReplyTemplate
  def self.render(pet:)
    <<~TEXT.chomp
      #{pet.owner_call_name}さんへ

      私は虹の麓の管理人です

      #{pet.name}ちゃんの代わりにお返事を書かせていただきますね

      #{pet.name}ちゃんはあなたからのお手紙をとても喜んでいました

      初めてここに来た日はとても驚いていましたが、

      今は気の合うお友達を見つけたようです

      仲良くできてよかったね、と私が言うと、

      自分が楽しい時は#{pet.owner_call_name}さんも楽しそうだったから、

      この手紙を読めば#{pet.owner_call_name}さんも喜んでくれると思う、と

      ニコニコしながら教えてくれました

      時々、あなたのことを嬉しそうに話してくれます

      きっとあなたのことを思い出すと

      #{pet.name}ちゃんは幸せな気持ちになれるんですね

      そして最後に、これは大切なことなので
      #{pet.name}ちゃんの言葉をそのまま書きますね

      『#{pet.owner_call_name}、大好きだよ』
    TEXT
  end

  private_class_method :new
end
